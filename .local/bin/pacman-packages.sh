#!/bin/bash
# pacman-packages - Build lists of installed packages or install packages from previously created lists
# inspired by:
# https://bbs.archlinux.org/viewtopic.php?pid=646685#p646685

# Use filename as program name
prog=${0##*/}

# Text color variables
bldblu='\e[1;34m'         # blue
bldred='\e[1;31m'         # red
bldwht='\e[1;37m'         # white
txtcyn='\e[1;36m'         # cyan
txtund=$(tput sgr 0 1)    # underline
txtbold=$(tput bold)      # bold
txtrst='\e[0m'            # text reset

info=[${bldblu}INFO${txtrst}]
debug=[${txtcyn}DEBU${txtrst}]
error=[${bldred}ERRO${txtrst}]

# binaries
PACMAN=/usr/bin/pacman
YAY=/usr/bin/yay
PACTREE=/usr/bin/pactree

# Utility functions
print_usage_and_exit() {
  echo -e "${txtbold}$prog${txtrst} - Build lists of installed packages or install packages from previously created lists

${txtbold}Usage${txtrst}:
$prog <command> [options]

${txtbold}Commands${txtrst}:
  build - build installed packages list. (default dir:${txtund}${PACMAN_PKG_LIST_FILE%/*}${txtrst})
  restore - restore installed packages from package list (WITHOUT CONFIRM!).

${txtbold}Options${txtrst}:
  -a | --aur-file
    Path to the AUR list file to be written/read
    (default: (${txtund}$HOME/.pacman-packages/aur.list${txtrst})
  -p | --pacman-file
    Path to the pacman list file to be written/read
    (default: (${txtund}$HOME/.pacman-packages/pacman.list${txtrst})
  -v | --verbose
    Print more messages

${txtbold}Examples${txtrst}:
  $prog build -> build the lists of installed packages using default filenames
  $prog restore -> install packages reading list files using default filenames
  $prog build -a /mnt/ext_disk/backup/aur.list -p /mnt/ext_disk/backup/pacman.list -> build the lists of installed packages writing in the specified filenames"
  exit 0
}

log() {
  echo -e "$info $1"
}

debug() {
  if [[ -n $DEBUG ]] ; then echo -e "$debug $1"; fi
}

error() {
  echo -e "$error $1"
}

# Parse arguments
if [ $# -lt 1 ]; then
  print_usage_and_exit
fi

case $1 in
  build)
    BUILD=true
    shift # past argument
    ;;
  restore)
    BUILD=false
    shift # past argument
    ;;
  -h|--help)
    print_usage_and_exit
    ;;
  *)
    error "Unknown command \"${txtbold}${1}${txtrst}\" - Run with \"--help\" to see available commands and options."
    exit 1;
esac

while [[ $# -gt 0 ]]; do
  case ${1} in
    -a|--aur-file)
      AUR_PKG_LIST_FILE=${2}
      shift # past argument
      shift # past value
      ;;
    -p|--pacman-file)
      PACMAN_PKG_LIST_FILE=${2}
      shift # past argument
      shift # past value
      ;;
    -v|--verbose)
      DEBUG=true
      shift # past argument
      ;;
    -*|--*)
      error "Unknown option \"${txtbold}${1}${txtrst}\" - Run with \"--help\" to see available commands and options."
      exit 1
      ;;
  esac
done

# Package list locations (pacman and AUR)
DEFAULT_DIR=${HOME}/.pacman-packages
PACMAN_PKG_LIST_FILE=${PACMAN_PKG_LIST_FILE:-${DEFAULT_DIR}/pacman.list}
AUR_PKG_LIST_FILE=${AUR_PKG_LIST_FILE:-${DEFAULT_DIR}/aur.list}

AUR_FILE_DIR=$(dirname -- ${AUR_PKG_LIST_FILE})
PACMAN_FILE_DIR=$(dirname -- ${PACMAN_PKG_LIST_FILE})

if [ ${BUILD} = "true" ]; then
  log "Building lists of packages..."
  # create BASEDIR if it does not exist
  if [[ ! -d ${PACMAN_FILE_DIR} ]] ; then
    debug "${PACMAN_FILE_DIR} does not exist, creating it..."
    mkdir -p "${PACMAN_FILE_DIR}";
  fi
  if [[ ! -d ${AUR_FILE_DIR} ]] ; then
    debug "${AUR_FILE_DIR} does not exist, creating it..."
    mkdir -p "${AUR_FILE_DIR}";
  fi

  # Create list of AUR packages
  debug "Creating list of installed AUR packages..."
  ${PACMAN} -Qqm > "${AUR_PKG_LIST_FILE}"
  log "AUR package list saved to ${txtund}${AUR_PKG_LIST_FILE}${txtrst}"

  debug "Creating list of pacman installe packages..."
  # Create list, remove AUR and "base" metapackage
  ${PACMAN} -Qqe | grep -vx "$(${PACTREE} -l -d 1 base)" | grep -vx "$(cat ${AUR_PKG_LIST_FILE})" > "${PACMAN_PKG_LIST_FILE}"
  log "Pacman package list saved to ${txtund}${PACMAN_PKG_LIST_FILE}${txtrst}"
else
  log "Restoring lists of packages..."
  # If restoring, be sure yay is installed
  if [[ -z $(${PACMAN} -Qs yay) ]]; then
      error "${prog} requires Yay to be installed. Install Yay (${txtund}https://github.com/Jguer/yay${txtrst}) and rerun."
      exit 1
  fi
  if [[ ! -f ${PACMAN_PKG_LIST_FILE} ]] && [[ ! -f ${AUR_PKG_LIST_FILE} ]] ; then
    error "List files not found!"
    exit 2;
  fi
  debug "Updating packages..."
  sudo ${PACMAN} -Sy
  debug "Installing packages from lists..."
  # use -f to overwrite conflicting files
  if [[ -f ${PACMAN_PKG_LIST_FILE} ]] ; then
    sudo ${PACMAN} -S --needed --noconfirm $(cat "${PACMAN_PKG_LIST_FILE}")
    log "Pacman packages restored"
  else
    log "Pacman packages list file not found, skipping."
  fi
  if [[ -f ${AUR_PKG_LIST_FILE} ]] ; then
    $YAY -S --needed --noconfirm $(cat "${AUR_PKG_LIST_FILE}" | grep -vx "$(pacman -Qqm)")
    log "AUR packages restored"
  else
    log "AUR packages list file not found, skipping."
  fi
fi

log Done!

alias watch='watch '
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='grep -F'
alias egrep='grep -E'
alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -CF'
alias k=kubectl
alias cd='z'
alias cd..='cd ..'
alias cls='clear'
alias sd='furyctl'
pswgen() { openssl rand -base64 100 | head -c"${1:-12}"; echo }
b64d() { echo -n "$1" | base64 -d ; }
b64e() { echo -n "$1" | base64 ; }
sdtail() { tail -f "${1:-${FURYCTL_LOG:-$(ls -Art ${FURYCTL_WORKDIR:-${HOME}}/.furyctl/*.log | tail -n 1)}}" | jq -j '.msg' ; }
# https://stackoverflow.com/a/73108928
dockersize() { docker manifest inspect -v "$1" | jq -c 'if type == "array" then .[] else . end | select(.Descriptor.platform.architecture != "unknown")' |  jq -r '[ ( .Descriptor.platform | [ .os, .architecture, .variant, ."os.version" ] | del(..|nulls) | join("/") ), ( [ ( .OCIManifest // .SchemaV2Manifest ).layers[].size ] | add ) ] | join(" ")' | numfmt --to iec --format '%.2f' --field 2 | sort | column -t ; }

# replace kubectx with fzf:
alias kctx="kubectl config get-contexts --no-headers --output name | fzf --height 20% --layout reverse --border --bind 'enter:become(kubectl config use-context {})'"
# replace kubens with fzf:
alias ksns="kubectl get ns --no-headers --output name | cut -d / -f2 | fzf --height 20% --layout reverse --border --bind 'enter:become(kubectl config set-context --current --namespace {})'"

# restartDnsMasq() { sudo launchctl unload /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist ; sudo launchctl load /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist ; dscacheutil -flushcache ; sudo launchctl stop homebrew.mxcl.dnsmasq ; sudo launchctl start homebrew.mxcl.dnsmasq }
flushDns() { sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder; }

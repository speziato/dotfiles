alias watch='watch '
alias ls='ls --color'
alias ll='ls -la'
alias k=kubectl
alias cd..='cd ..'
alias cls='clear'
pswgen() { openssl rand -base64 100 | head -c"${1:-12}"; echo }
b64d() { echo -n "$1" | base64 -d ; }
b64e() { echo -n "$1" | base64 ; }

# replace kubectx with fzf:
alias kctx="kubectl config get-contexts --no-headers --output name | fzf --height 20% --layout reverse --border --bind 'enter:become(kubectl config use-context {})'"
# replace kubens with fzf:
alias ksns="kubectl get ns --no-headers --output name | cut -d / -f2 | fzf --height 20% --layout reverse --border --bind 'enter:become(kubectl config set-context --current --namespace {})'"

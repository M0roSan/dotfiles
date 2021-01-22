alias upd=". ~/.bash_profile"
alias ebash="code ~/.bash_profile"
alias grep="grep --color=auto"
alias python=python3
alias pip=pip3
alias gp='git pull'
alias dei='docker run --entrypoint "/bin/sh" -it'
alias dp='docker pull'
alias ls='ls -GFh'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lsg='ls | grep'
alias av='. venv/bin/activate'
alias gcb='git checkout -b'
alias c='code'
alias k='kubectl'
alias kcc='kubectl config use-context '
alias kcn='kubectl config set-context --current --namespace '
alias ss='sft ssh'
alias slp='sft list-servers --project'
alias tfmt='terraform fmt'
alias tvali='terraform validate'
alias tplan='terraform plan'
export BASH_COMPLETION_COMPAT_DIR="/usr/local/etc/bash_completion.d"
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
source <(kubectl completion bash)
complete -F __start_kubectl k

export HISTCONTROL=ignoreboth:

# go env
export GOPATH=$HOME/go
export GOPRIVATE=""
export PATH=$PATH:$GOPATH/bin

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[36m\]\h:\[\033[32m\]\W\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

eval "$(rbenv init -)" > /dev/null 2>&1
ssh-add -K ~/.ssh/id_rsa > /dev/null 2>&1

# gitlab curl
GITLAB_API_TOKEN=""
GITLAB_SUDO_TOKEN=""
GITLAB_URL=""
cgit() {
  default=0
  token=''
  read -p "Enter 0 for api and 1 for sudo[default $default]: " input
  choice=${input:-$default}
  case $choice in 
    0)
      token=$GITLAB_API_TOKEN;;
    1)
      token=$GITLAB_SUDO_TOKEN;;
    *)
      echo "choice has to be 0 or 1"
      :;;
  esac
  curl --header "PRIVATE-TOKEN: $token" https://$GITLAB_URL/api/v4/$1 ${@:2}
}


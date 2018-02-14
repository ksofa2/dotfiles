export PATH=${HOME}/bin:/usr/local/bin:/opt/bin:${PATH}
alias dotfiles='$(which git) -c status.showUntrackedFiles=no --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

alias tacc='tmux -CC attach -t'
alias tadcc='tmux -CC attach -d -t'
alias tscc='tmux -CC new-session -s'

# who and where am i:
alias wwami='echo "$(whoami)@$(hostname):$(pwd)"'

# activate a python virtualenv
function activate() {
    if [ ! -z "${VIRTUAL_ENV}" ]; then
      echo "Already active ${VIRTUAL_ENV}"
      return 0
    fi

    external_venv="${HOME}/.virtualenvs/$(basename $(pwd))"
    internal_venv="venv"
    if [ -d "${internal_venv}" ]; then
        venv=${internal_venv}
    elif [ -d "${external_venv}" ]; then
        venv=${external_venv}
    else
        echo "Could not find a virtualenv in ./${internal_venv} or ${external_venv}"
        return 1
    fi

    activate="${venv}/bin/activate"
    if [ -f "${activate}" ]; then
        source "${activate}" &&
            echo "Activated ${venv}"
    else
        echo "${activate} does not exist"
        return 1
    fi
}


# set docker-machine env variables
function docker-env() {
   VARS=`docker-machine env`;
   if [ $? -ne 0 ]; then
       echo -e '\nCould not set Docker variables.'
       return 1
   else
       eval ${VARS}
       print ${VARS}
       echo -e '\nDocker variables set.'
       return 0
   fi
}


# Path to your oh-my-zsh installation.
export ZSH=${HOME}/.oh-my-zsh

ZSH_THEME="kris"
ZSH_CUSTOM=${HOME}/.oh-my-zsh-custom

COMPLETION_WAITING_DOTS="true"
DISABLE_AUTO_UPDATE="true"

plugins=(git git-prompt virtualenv django python tmux vagrant kubectl minikube)

export ZSH_TMUX_ITERM2=true
source $ZSH/oh-my-zsh.sh

export EDITOR='vim'

unsetopt share_history

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# added by travis gem
[ -f /Users/steinhof/.travis/travis.sh ] && source /Users/steinhof/.travis/travis.sh

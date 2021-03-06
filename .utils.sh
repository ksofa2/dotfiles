export PATH=${HOME}/bin:${HOME}/.local/bin:${PATH}:$/opt/bin:{HOME}/go/bin
alias dotfiles='$(which git) -c status.showUntrackedFiles=no --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

alias tacc='tmux -CC attach -t'
alias tadcc='tmux -CC attach -d -t'
alias tscc='tmux -CC new-session -s'

alias glg="git log --decorate --graph --pretty=format:'%C(yellow)%h%C(reset) - %s %C(green)(%cr) %C(cyan)<%an>%C(reset) %C(yellow)%d%Creset'"
# who and where am i:
alias wwami='echo "$(whoami)@$(hostname):$(pwd)"'
export EDITOR=${OVERRIDE_EDITOR-'vim'}
export PIP_DISABLE_PIP_VERSION_CHECK=1

# activate a python virtualenv
function activate() {
    if [ ! -z "${VIRTUAL_ENV}" ]; then
      echo "Already active ${VIRTUAL_ENV}, unsetting VIRTUAL_ENV] ..."
      unset VIRTUAL_ENV
    fi

    dir="$(pwd)"
    name="$(basename ${dir})"
    external_venv="${HOME}/.virtualenvs/${name}"
    internal_venv="venv"
    if [ -d "${internal_venv}" ]; then
        venv="${internal_venv}"
    elif [ -d "${external_venv}" ]; then
        venv="${external_venv}"
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


function ls_or_page() {
    TARGET=${1:-'.'}

    if [ -d "${TARGET}" ]; then
        ls -la "${TARGET}"
    elif [ -f "${TARGET}" ]; then
        ${PAGER:-"cat"} "${TARGET}"
    else
        echo "ERROR: could not ls or ${PAGER:-'cat'} ${TARGET}"
    fi
}

alias c=ls_or_page

function t() {
    DEFAULT_SESSION=$(echo $(basename $(pwd)) | tr '.' '_')
    SESSION="${*:-${DEFAULT_SESSION}}"
    tmux list-sessions | grep -q "^${SESSION}" > /dev/null; rc=$?
    if [ ${rc} -eq 0 ]; then
        tmux ${TMUX_OPTIONS} attach-session -d -t "${SESSION}"
    else
        tmux ${TMUX_OPTIONS} new-session -s "${SESSION}"
    fi
}

function tcc() {
    TMUX_OPTIONS='-CC'
    t ${*}
}

test -f "${HOME}/.travis/travis.sh" && source "${HOME}/.travis/travis.sh"

test -d "${HOME}/.vim/pack/" && echo "${HOME}/.vim/pack/ exists"
test -d "${HOME}/.vim/bundle/" && echo "${HOME}/.vim/bundle/ exists"

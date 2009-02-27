## to use, include this line in your .bashrc file
#
# test -e ${HOME}/.bashrc_common.sh && source ${HOME}/.bashrc_common.sh
#

if [ "${BASH-no}" != "no" ]; then
	[ -r /etc/bashrc ] && . /etc/bashrc
fi

export PROMPT_COMMAND=bigPrompt

export PATH="/bin:/sbin:/usr/bin:/usr/sbin:/usr/X11/bin"
export MANPATH="/usr/share/man:/usr/X11R6/man"

export VISUAL="vim"
export EDITOR="vim"
export CVS_RSH="ssh"

export PATH=${HOME}/bin:${PATH}

export HISTIGNORE=exit:logout
export HISTFILESIZE=1000

# alias cd=pushd
# alias bd=popd

# {{{ Define colors
COLOR_PROMPT_RED="\[\e[31m\]"
COLOR_PROMPT_GREEN="\[\e[32m\]"
COLOR_PROMPT_YELLOW="\[\e[33m\]"
COLOR_PROMPT_BLUE="\[\e[34m\]"
COLOR_PROMPT_MAGENTA="\[\e[35m\]"
COLOR_PROMPT_CYAN="\[\e[36m\]"

COLOR_PROMPT_RED_BOLD="\[\e[31;0m\]"
COLOR_PROMPT_GREEN_BOLD="\[\e[32;0m\]"
COLOR_PROMPT_YELLOW_BOLD="\[\e[33;0m\]"
COLOR_PROMPT_BLUE_BOLD="\[\e[34;0m\]"
COLOR_PROMPT_MAGENTA_BOLD="\[\e[35;0m\]"
COLOR_PROMPT_CYAN_BOLD="\[\e[36;0m\]"

COLOR_PROMPT_NONE="\[\e[0m\]"

COLOR_RED="\e[31m"
COLOR_GREEN="\e[32m"
COLOR_YELLOW="\e[33m"
COLOR_BLUE="\e[34m"
COLOR_MAGENTA="\e[35m"
COLOR_CYAN="\e[36m"

COLOR_RED_BOLD="\e[31;0m"
COLOR_GREEN_BOLD="\e[32;0m"
COLOR_YELLOW_BOLD="\e[33;0m"
COLOR_BLUE_BOLD="\e[34;0m"
COLOR_MAGENTA_BOLD="\e[35;0m"
COLOR_CYAN_BOLD="\e[36;0m"

COLOR_NONE="\e[0m"
# }}} END Define colors

# {{{ Operating System specific settings
case `uname` in
    Darwin)
        test -r /sw/bin/init.sh && . /sw/bin/init.sh

        # Sets up colorized ls
        export TERM=xterm-color
        export CLICOLOR=true
        export LSCOLORS=gxfxcxdxbxegedabagacad

        alias l='ls'
        alias ll='ls -lah'
        alias ttop='top -ocpu -R -F -n30'

        export HOST=`hostname -s`
        ;;
    Linux)
        export LS_COLORS="no=00:fi=00:di=00;36:ln=00;35:pi=40;33:so=00;35:do=00;35:bd=40;33;00:cd=40;33;00:or=40;31;00:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=00;32:"
        alias ls='ls --color'
        alias l='ls -F'
        alias ll='ls -Flah'

        export HOST=${HOSTNAME}
    ;;
esac
# }}} END Operating System specific settings

# {{{ Prompts
if [ $UID -eq 0 ]; then
    export PROMPT_CHAR="#"
else
    export PROMPT_CHAR="$"
fi

tinyPrompt()
{
    PREV_RET_VAL=$?;

    PS1=""

    if test $PREV_RET_VAL -eq 0
    then
        PS1="${PS1}${COLOR_PROMPT_GREEN}${PROMPT_CHAR}${COLOR_PROMPT_NONE} "
    else
        PS1="${PS1}${COLOR_PROMPT_RED}${PREV_RET_VAL} ${PROMPT_CHAR}${COLOR_PROMPT_NONE} "
    fi
}

bigPrompt()
{
    PREV_RET_VAL=$?;
    PS1=""

        PS1="${PS1}${COLOR_PROMPT_YELLOW}\u${COLOR_PROMPT_NONE}"

        PS1="${PS1}@${COLOR_PROMPT_RED}\h${COLOR_PROMPT_NONE}:${COLOR_PROMPT_YELLOW}\w${COLOR_PROMPT_NONE}"

        if test $PREV_RET_VAL -eq 0
        then
            PS1="${PS1}\n${COLOR_PROMPT_GREEN}${PROMPT_CHAR}${COLOR_PROMPT_NONE} "
        else
            PS1="${PS1}\n${COLOR_PROMPT_RED}[${PREV_RET_VAL}] ${PROMPT_CHAR}${COLOR_PROMPT_NONE} "
        fi
}

scmPrompt()
{
    PREV_RET_VAL=$?;

    PS1=""

        PS1="${PS1}${COLOR_PROMPT_YELLOW}\u${COLOR_PROMPT_NONE}"
        PS1="${PS1}@${COLOR_PROMPT_RED}\h${COLOR_PROMPT_NONE}:${COLOR_PROMPT_YELLOW}\w${COLOR_PROMPT_NONE}"

        git branch &> /dev/null; rc=$?;
        if [ $rc -eq 0 ]; then
            BRANCH=`git branch --no-color | grep ^\* | sed s/\*\ //g`
            if [ "x${BRANCH}" = "xmaster" ]; then
                INFO=""
            else
                INFO="${BRANCH}:"
            fi
            COMMIT=`git log -1 | head -1 | awk '{print $2}' | cut -c 1-7`
            INFO=${INFO}${COMMIT};
            git status 2> /dev/null | tail -n1 | grep 'working directory clean' &> /dev/null; rc=$?
            if [ $rc -eq 0 ]; then
                STATE_COLOR=${COLOR_PROMPT_GREEN}
            else
                STATE_COLOR=${COLOR_PROMPT_RED}
            fi
            PS1="${PS1} ${STATE_COLOR}[${INFO}]${COLOR_PROMPT_NONE}"
        fi

        if test $PREV_RET_VAL -eq 0
        then
            PS1="${PS1}\n${COLOR_PROMPT_GREEN}${PROMPT_CHAR}${COLOR_PROMPT_NONE} "
        else
            PS1="${PS1}\n${COLOR_PROMPT_RED}[${PREV_RET_VAL}] ${PROMPT_CHAR}${COLOR_PROMPT_NONE} "
        fi
}

hugePrompt()
{
    PREV_RET_VAL=$?;

    PS1=""

        if test "$USER" != "root"
            then
                PS1="${PS1}${COLOR_PROMPT_YELLOW}\u${COLOR_PROMPT_NONE}"
        else
            PS1="${PS1}${COLOR_PROMPT_RED}\u${COLOR_PROMPT_NONE}"
                fi

                PS1="${PS1}@${COLOR_PROMPT_RED}\h${COLOR_PROMPT_NONE}:${COLOR_PROMPT_YELLOW}\w ${COLOR_PROMPT_CYAN}  \d \t ${COLOR_PROMPT_MAGENTA}\! ${COLOR_PROMPT_NONE}"

            if test $PREV_RET_VAL -eq 0
                then
                    PS1="${PS1}\n${COLOR_PROMPT_GREEN}${PROMPT_CHAR}${COLOR_PROMPT_NONE} "
            else
                PS1="${PS1}\n${COLOR_PROMPT_RED}[${PREV_RET_VAL}] ${PROMPT_CHAR}${COLOR_PROMPT_NONE} "
            fi
}

PS2="${COLOR_PROMPT_GREEN}>${COLOR_PROMPT_NONE} "
# }}} END Prompts

# {{{ SSH helpers functions
test -r .ssh/agent-init.sh && source .ssh/agent-init.sh >& /dev/null

ssh-agent-start () {
    TMP=`mktemp /tmp/ssh-start.XXXX`

    ssh-add -l >& ${TMP}; rc=$?

    if [ $rc = 0 ]; then
        echo The ssh-agent is already running.
        cat ${TMP}
    elif [ $rc = 1 ]; then
        echo The ssh-agent is already running.
        cat ${TMP}
        ssh-add
    else
        ssh-agent -t 86400 > ~/.ssh/agent-init.sh
        source ~/.ssh/agent-init.sh
        echo The ssh-agent has been started.
        ssh-add
    fi

    rm ${TMP}
}

ssh-agent-grab-env () {
    SSHVARS="SSH_CLIENT SSH_TTY SSH_AUTH_SOCK SSH_CONNECTION DISPLAY"

    for x in ${SSHVARS} ; do
        (eval echo $x=\$$x) | sed 's/=/="/' | sed 's/$/"/' | sed 's/^/export /'
    done 1>~/.ssh/agent-env
}

ssh-agent-fix () {
    AGENT_ENV=~/.ssh/agent-env

    test -r ${AGENT_ENV} && source ${AGENT_ENV} && cat ${AGENT_ENV}
}
# }}} END SSH helpers functions

# {{{ Misc helper functions
creds () {
    klist -5 || kinit
    echo ""
    ssh-add -l || ssh-agent-start
}

attach () {
   titleset
   ssh-agent-grab-env && screen -dR $*
}

huh()
{
    date=`date`
    echo -e "\e[32mTime:\e[0m \e[33m${date}\e[0m"
    echo -e "\e[32mUser:\e[0m \e[33m${USER}\e[0m"
    echo -e "\e[32mHost:\e[0m \e[33m`hostname`\e[0m"
    echo -e " \e[32mPWD:\e[0m \e[33m`pwd`\e[0m"

    # Set terminal window's title to user@hostname
    echo -ne "\033]0;${USER}@`hostname -s`\007"
}

titleset()
{
    if [ "${*}" ]; then
        TITLE="${*}"
    else
        if [ ! ${HOST} ]; then
           HOST=`hostname`
        fi
        TITLE=${USER}@${HOST}
    fi

    echo -ne "\033]0;${TITLE}\007"
}

dotfilesupdate()
{
    for DOTFILE in .bashrc .inputrc .screenrc .vimrc .gitrc; do
        cp -v ${HOME}/${DOTFILE} ${HOME}/${DOTFILE}.bak
        scp sftp.web.itd.umich.edu:${DOTFILE} ${HOME}/{$DOTFILE}
    done
}
# }}} END Misc helper functions

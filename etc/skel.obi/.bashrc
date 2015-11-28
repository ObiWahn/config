# Copyright - 2010 - Jan Christoph Uhde <Jan@UhdeJC.com>
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

export UNAME="$(uname)"
export HOSTNAME

declare -r TMP_PATH="$PATH" 2>/dev/null

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# use ** for recursive stuff
if (( BASH_VERSINFO >= 4 )); then
    shopt -s globstar
fi

# disable visual bells
# set bell-style none

# make less more friendly for non-text input files, see lesspipe
[[ -x /usr/bin/lesspipe ]] && eval "$(SHELL=/bin/sh lesspipe)"
[[ -x /usr/bin/lessfile ]] && eval "$(SHELL=/bin/sh lessfile)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot="$(cat /etc/debian_chroot)"
fi

#enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


PS1="\u@\H:\w\$ "

#if profile should not be loaded for some reason
if ! declare -f source_file &>/dev/null; then
    source_file(){
        local file_name="$1"
        local exp_owner="$2"

        if [[ -f "$file_name" ]]; then
            if [[ -z "$exp_owner" ]]; then
                source "$file_name"
            else
                local owner="$(get_own "$file_name")"
                [[ $exp_owner == $owner ]] && source "$file_name"
            fi
            return 0
        else
            return 1
        fi
    }
    export -f source_file
fi

source_file ~/.bashrc.d/all/prompt

#stty -ixon -ixoff

## find free xdisplay
xdisplay(){
    local disp=0
    while [ -e "/tmp/.X${disp}-lock" ]; do
	    disp=$(( $disp + 1 ))
    done
    echo $disp
}
export -f xdisplay

###ALL USER
source_file ~/.bashrc.d/all/bash_lib
source_file ~/.bashrc.d/all/basic
source_file ~/.bashrc.d/all/history

###THIS HOST
source_file ~/.bashrc.d/host/$HOSTNAME

###THIS USER
source_file ~/.bashrc.d/user/private
source_file ~/.bashrc.d/user/ssh_common
source_file ~/.bashrc.d/user/ssh_$HOSTNAME

source_file ~/.bashrc.d/user/$USER
source_file ~/.bashrc.d/user/${USER}_$HOSTNAME


export PATH="$TMP_PATH"												#define GUARD
export LD_LIBRARY_PATH=""

# Copyright - 2010 - Jan Christoph Uhde <Jan@UhdeJC.com>
# If not running interactively, don't do anything

# shellcheck shell=bash
[ -z "$PS1" ] && return

OBI_IN_BASHRC=true
obi_late_profile=false
if [[ $OBI_PROFILE_SOURCED != true ]]; then
    echo "profile not sourced"
    obi_late_profile=true
    # shellcheck disable=SC1090
    . "$HOME/.bash_profile"
fi

declare -r path_saved="$PATH" 2>/dev/null
declare -r ld_library_path_saved="${LD_LIBRARY_PATH:-}" 2>/dev/null

UNAME="$(uname)"

export UNAME
export HOSTNAME

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

PS1='\u@\H:\w\$ '
source_file ~/.bashrc.d/all/prompt
#use short host names
hostname="${HOSTNAME%%.*}"

source_file ~/.bashrc.d/all/basic
source_file ~/.bashrc.d/all/commands
source_file ~/.bashrc.d/all/history
source_file ~/.bashrc.d/user/history

###THIS HOST
source_file ~/.bashrc.d/host/"$hostname"

###THIS USER
source_file ~/.bashrc.d/user/private
source_file ~/.bashrc.d/user/ssh_common
source_file ~/.bashrc.d/user/"ssh_$hostname"

source_file ~/.bashrc.d/user/"$USER"
source_file ~/.bashrc.d/user/"${USER}_$hostname"


export PATH="$path_saved"												#define GUARD

if [[ $obi_late_profile == 'true' ]]; then
    export LD_LIBRARY_PATH="$ld_library_path_saved"
else
    unset LD_LIBRARY_PATH
    export -n LD_LIBRARY_PATH
fi

unset OBI_IN_BASHRC

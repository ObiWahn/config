# ~/.bash_profile: executed by bash(1) for login shells.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

#make sure noemesses here
export LD_LIBRARY_PATH=""

umask 022

_o_os_linux="no"
_o_os_mac="no"
_o_os_windows="no"

_o_system_tmux=/usr/bin/tmux
_o_system_vim=/usr/bin/vim
_o_system_gnu_grep=/bin/grep
_o_system_gnu_readlink=/bin/readlink

case "$(uname)" in
    Linux)
        _o_os_linux="yes"
        get_own(){ stat -c %U "$(${_o_system_gnu_readlink} -f "$1")"; };
    ;;
    Darwin)
        _o_os_mac="yes"
        _o_system_tmux=/usr/local/bin/tmux
        _o_system_vim=/usr/local/bin/vim
        _o_system_gnu_grep=/usr/local/opt/grep/libexec/gnubin/grep
        _o_system_gnu_readlink=/usr/local/opt/coreutils/libexec/gnubin/readlink
        PATH="/usr/local/opt/coreutils/libexec/gnubin/:$PATH"
        get_own(){ stat -c %U "$(${_o_system_gnu_readlink} -f "$1")"; };
        #get_own(){ stat -f %Su "$1"; };
    ;;
    *)
        echo "unsupported os"
        get_own(){ echo "unknown user"; };
    ;;
esac

export _o_os_linux
export _o_os_mac
export _o_os_windows

export _o_system_tmux
export _o_system_vim
export _o_system_gnu_grep
export _o_system_gnu_readlink


## source file
source_file(){
    local file_name="$1"
    local exp_owner="$2"

    if [[ -f "$file_name" ]]; then
        if [[ -z "$exp_owner" ]]; then
            source "$file_name"
        else
            local owner="$(get_own "$file_name")"
            if [[ $exp_owner == $owner ]]; then
                source "$file_name"
            else
                echo "$file_name not owned by $exp_owner! Not sourcing file!"
            fi
        fi
        return 0
    else
        return 1
    fi
}
export -f source_file

if (( $BASH_VERSINFO >= 4 )); then
    source_file ~/.bashrc.d/all/bash_lib
fi

## find free xdisplay
xdisplay(){
    local disp=0
    while [ -e "/tmp/.X${disp}-lock" ]; do
	    disp=$(( $disp + 1 ))
    done
    echo $disp
}
export -f xdisplay

# set PATH so it includes user's private bin if it exists
if [ -d ~/.bin ] ; then
    PATH="${PATH}":~/.bin
fi

add_to_head_of_PATH() {
	if [[ -d "$1" ]]; then
        owner="$(get_own "$1")"
	    [[ $owner = "root" ]] && PATH="$1":"${PATH}"
	fi
}

add_to_tail_of_PATH() {
	if [[ -d "$1" ]]; then
	    PATH="${PATH}":"$1"
	fi
}

add_to_head_of_PATH ~/.bin_safe/wrapper
add_to_head_of_PATH ~/.bin_safe/sudo
add_to_head_of_PATH ~/.bin_safe

add_to_tail_of_PATH ~/.bashrc.d/all/scripts
add_to_tail_of_PATH /usr/opt/scripts
add_to_tail_of_PATH ~/.local/bin
add_to_tail_of_PATH ~/.cargo/bin
add_to_tail_of_PATH ~/.stack
add_to_tail_of_PATH ~/.stack/bin
add_to_tail_of_PATH ~/.cabal/bin
add_to_tail_of_PATH ~/.node_modules/bin

# do the same with MANPATH
#if [ -d ~/man ]; then
#    MANPATH=~/man:"${MANPATH}"
#fi

userdirs=~/.config/user-dirs.dirs
if [ -f $userdirs ]; then
    owner="$(get_own "$userdirs")"
	[[ $owner = "root" ]] && source $userdirs

    export XDG_CONFIG_HOME
    export XDG_DESKTOP_DIR
    export XDG_DOWNLOAD_DIR
    export XDG_TEMPLATES_DIR
    export XDG_PUBLICSHARE_DIR
    export XDG_DOCUMENTS_DIR
    export XDG_MUSIC_DIR
    export XDG_PICTURES_DIR
    export XDG_VIDEOS_DIR
fi

export PATH
export LD_LIBRARY_PATH=""

# USER PROFILE - They must be owned by root
source_file ~/.bashrc.d/user/profile_common              root
source_file ~/.bashrc.d/user/profile_${USER}             root
source_file ~/.bashrc.d/user/profile_${USER}_${HOSTNAME%%.*} root

if [[ ${_o_os_mac} == yes ]]; then
    for file in /usr/local/etc/obi.profile.d/*; do
        source_file "$file"
    done
fi

export OBI_PROFILE_SOURCED=true

# include .bashrc if it exists
if [[ ${OBI_IN_BASHRC:-false} != true && -f ~/.bashrc ]]; then
    source ~/.bashrc
fi

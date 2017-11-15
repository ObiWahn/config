# ~/.bash_profile: executed by bash(1) for login shells.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

#make sure noemesses here
export LD_LIBRARY_PATH=""

umask 022

case "$(uname)" in
    Linux)
        get_own(){ stat -c %U "$(readlink -f "$1")"; };
    ;;
    Darwin)
        get_own(){ stat -f %Su "$1"; };
    ;;
    *)
        get_own(){ echo "unknown"; };
    ;;
esac

## source file
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

## find free xdisplay
xdisplay(){
    local disp=0
    while [ -e "/tmp/.X${disp}-lock" ]; do
	    disp=$(( $disp + 1 ))
    done
    echo $disp
}
export -f xdisplay

# include .bashrc if it exists
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

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

add_to_tail_of_PATH /usr/opt/scripts
add_to_tail_of_PATH ~/.cargo/bin
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

# ~/.bash_profile: executed by bash(1) for login shells.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

#make sure noemesses here
export LD_LIBRARY_PATH=""

umask 022

source ~/.bashrc.d/all/bash_system_specific

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

# Add to items to PATH
add_to_head_of_PATH ~/.bin_safe/wrapper
add_to_head_of_PATH ~/.bin_safe/sudo
add_to_head_of_PATH ~/.bin_safe

add_to_tail_of_PATH ~/.bin
add_to_tail_of_PATH ~/.bashrc.d/all/scripts
add_to_tail_of_PATH /usr/opt/scripts
add_to_tail_of_PATH ~/.local/bin
add_to_tail_of_PATH ~/.cargo/bin
add_to_tail_of_PATH ~/.stack
add_to_tail_of_PATH ~/.stack/bin
add_to_tail_of_PATH ~/.cabal/bin
add_to_tail_of_PATH ~/.node_modules/bin
add_to_tail_of_PATH ~/.go/bin

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

SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"; export SSH_AUTH_SOCK

if (( $BASH_VERSINFO >= 4 )); then
    source ~/.bashrc.d/all/bash_lib
else
    ## source file - check that it is the same as in bash_lib
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
fi

# HOST PROFILE - They must be owned by root
source_file ~/.bashrc.d/host/profile                         root

# USER PROFILE - They must be owned by root
source_file ~/.bashrc.d/user/profile_common                  root
source_file ~/.bashrc.d/user/profile_${USER}                 root
source_file ~/.bashrc.d/user/profile_${USER}_${HOSTNAME%%.*} root

#hack for macos and brew
if [[ ${_o_os_mac} == yes ]]; then
    for file in /usr/local/etc/obi.profile.d/*; do
        source_file "$file"
    done
fi

# Do not pull down!!! (bashrc has to be sourced later)
export OBI_PROFILE_SOURCED=true

# include .bashrc if it exists
if [[ ${OBI_IN_BASHRC:-false} != true && -f ~/.bashrc ]]; then
    source ~/.bashrc
fi

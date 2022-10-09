# This file is read each time a login shell is started.
# All other interactive shells will only read .bashrc; this is particularly
# important for language settings, see below.

export EDITOR=/usr/bin/nvim
export PATH="${HOME}/.dotnet/:${HOME}/.local/bin:${HOME}/.cargo/bin:${PATH}"
#export LC_ALL=en_US.UTF-8
#export LANG=en_US.UTF-8
shopt -s extglob
shopt -s autocd
# Load/launch tmux if the user owns this script, bash is interactive,
# the environment is not a Vim Terminal, and this is not a subshell.
if [[ -O "$BASH_SOURCE" && $- == *i* && ! $VIM_TERMINAL ]] && [ -n "${DISPLAY}" ] && [ -z "${TMUX}" ]; then # && (SHLVL <3)
	command tmux attach || command tmux 
fi

HISTIGNORE="ls:bg:fg:exit:reset:clear:cd"
HISTCONTROL="ignoreboth:erasedups"
HISTSIZE=1000
HISTFILESIZE=2000

ZYPP_MEDIANETWORK=1

WINEDEBUG=fixme-all

eval $(dircolors ~/.dir_colors)

alias vim=nvim
alias ls="ls -AhF --color=auto --group-directories-first"
alias browse='fzf --bind="enter:execute(echo -n {} | wl-copy)" --preview="pygmentize {} 2>/dev/null || cat {}" --preview-window=up'
alias grep="grep --color=auto --binary-files=without-match --devices=skip"
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"
alias mpa="mpv --profile=audio"
alias ytdl2c="yt-dlp --external-downloader aria2c --downloader-args 'aria2c:--continue true --retry-wait=30 -j 5 -x 5 -s 5 -k 1M'"
alias cp="cp -ip"
alias mv="mv -i"
alias rm="rm -i"
alias mkdir="mkdir -pv"
alias du="du -ach | sort -h"
alias diff="diff -Naup --color=auto"
alias traffic="sudo ss -tp4"
alias windesktop="/mnt/c/Users/llyyr/Desktop/"
alias brplay="~/.local/share/Steam/steamapps/compatdata/291550/pfx/drive_c/users/steamuser/BrawlhallaReplays"
alias rg="rg --smart-case"
alias dotfiles="/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME"
alias localejp="LC_ALL=ja_JP.UTF-8 LANG=ja_JP.UTF-8"
alias cpug="sudo cpupower frequency-set -g $1"
alias runvenv="source env/bin/activate"
alias ghc="ghc -no-keep-hi-files -no-keep-o-files $1"
alias screenoff="swayidle timeout 3 'swaymsg \"output * dpms off\"' resume 'swaymsg \"output * dpms on\"'"
#temp lol
alias gbf2="microsoft-edge-beta --profile-directory='Profile 2' --ozone-platform-hint=auto --disable-backgrounding-occluded-windows"
alias discord-canary="discord-canary --no-sandbox --disable-smooth-scrolling" 
alias discordtest="discord-canary --no-sandbox --disable-smooth-scrolling --enable-features=UseOzonePlatform --ozone-platform=wayland"

colpick() {
    grim -g "$(slurp -p)" -t ppm - | convert - -format '%[pixel:p{0,0}]' txt:-
}

waylandrc() {
    #wf-recorder -g "$(slurp)" -c h264_vaapi -d /dev/dri/renderD128 --force-yuv -f ~/Videos/$(date +'%Y%m%d-%H%M').mp4
    wf-recorder -g "$(slurp)" --audio -f ~/Videos/$(date +'%Y%m%d-%H%M').mp4
}

gbfrc() {
    wf-recorder -g "1046,144 320x581" -f ~/Videos/$(date +'%Y%m%d-%H%M').mp4
}

upload-file() {
    if [ $# -eq 0 ]; then
        curl -s -F file=@- https://0x0.st
    else
        curl -s -F file=@"$1" https://0x0.st
    fi
}

mkcd() {
    test -d "$1" || mkdir "$1" && cd "$1"
}

wttr() {
    if [ -z $1 ]; then
        curl -s "v2.wttr.in/Jamal+Patna"
    else
        curl -s "v2.wttr.in/$1"
    fi
}

cheat() {
    if [ -z $1 ]; then
        curl -s "cheat.sh"
    else
        curl -s "cheat.sh/$1"
    fi
}

# fuzzy find (case insensitive)
function ff() {
	local pattern="$1"
	shift
	if [ $# -eq 0 ]; then
		set -- .
	fi
	find "$@" | grep -i -- "$pattern"
}

function man() {
	LESS_TERMCAP_md=$'\e[1;36m' \
	LESS_TERMCAP_me=$'\e[0m' \
	LESS_TERMCAP_us=$'\e[1;32m' \
	LESS_TERMCAP_ue=$'\e[0m' \
	GROFF_NO_SGR=1 \
	command man "$@"
}

incd() {
    if [ -z $1 ]; then
        ls -i
    else
        cd $(find . -maxdepth 1 -inum $1)
    fi
}


n ()
{
    # Block nesting of nnn in subshells
    if [[ "${NNNLVL:-0}" -ge 1 ]]; then
        echo "nnn is already running"
        return
    fi
    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
    # see. To cd on quit only on ^G, remove the "export" and make sure not to
    # use a custom path, i.e. set NNN_TMPFILE *exactly* as follows:
    #     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef
    export NNN_PLUG='d:dragdrop'

    # The backslash allows one to alias n to nnn if desired without making an
    # infinitely recursive alias
    \nnn "$@"

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}

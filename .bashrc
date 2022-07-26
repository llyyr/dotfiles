# This file is read each time a login shell is started.
# All other interactive shells will only read .bashrc; this is particularly
# important for language settings, see below.

export EDITOR=/usr/bin/nvim
export PATH="${HOME}/.dotnet/:${HOME}/.local/bin:${PATH}"
#export LC_ALL=en_US.UTF-8
#export LANG=en_US.UTF-8
shopt -s autocd

# Load/launch tmux if the user owns this script, bash is interactive,
# the environment is not a Vim Terminal, and this is not a subshell.
[[ -O "$BASH_SOURCE" && $- == *i* && ! $VIM_TERMINAL ]] && ((SHLVL < 3)) &&
	{ command tmux ls && command tmux -2 attach || command tmux -2; }

HISTIGNORE="ls:bg:fg:exit:reset:clear:cd"
HISTCONTROL="ignoreboth:erasedups"
HISTSIZE=1000
HISTFILESIZE=2000

ZYPP_MEDIANETWORK=1

WINEDEBUG=fixme-all

eval $(dircolors ~/.dir_colors)

alias vim=nvim
alias ls="ls -AhF --color=auto --group-directories-first"
alias grep="grep --color=auto --binary-files=without-match --devices=skip"
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"
alias mpa="mpv --profile=audio"
alias yt-dlp-aria2c="yt-dlp --external-downloader aria2c --downloader-args 'aria2c:--continue true --retry-wait=30 -j 5 -x 5 -s 5 -k 1M'"
alias cp="cp -ip"
alias mv="mv -i"
alias rm="rm -i"
alias mkdir="mkdir -pv"
alias du="du -ach | sort -h"
alias diff="diff -Naup"
alias traffic="sudo ss -tp4"
alias windesktop="/mnt/c/Users/llyyr/Desktop/"
alias brplay="~/.local/share/Steam/steamapps/compatdata/291550/pfx/drive_c/users/steamuser/BrawlhallaReplays"
alias f="ag --smart-case --skip-vcs-ignores"
alias blank="sleep 1; xset dpms force off"
alias dotfiles="/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME"
alias localejp="LC_ALL=ja_JP.UTF-8 LANG=ja_JP.UTF-8"
alias cpug="sudo cpupower frequency-set -g $1"
alias runvenv="source env/bin/activate"
alias ghc="ghc -no-keep-hi-files -no-keep-o-files $1"
#alias xpaste="xclip -selection clipboard -o"
#alias xcopy="xclip -selection c"
alias screenoff="swayidle timeout 10 'swaymsg \"output * dpms off\"' resume 'swaymsg \"output * dpms on\"'"
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
        exec curl -F file=@- https://0x0.st
    else
        exec curl -F file=@"$1" https://0x0.st
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

function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
 else
    for n in "$@"
    do
      if [ -f "$n" ] ; then
          case "${n%,}" in
            *.cbt|*.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar) 
                         tar xvf "$n"       ;;
            *.lzma)      unlzma ./"$n"      ;;
            *.bz2)       bunzip2 ./"$n"     ;;
            *.cbr|*.rar) unrar x -ad ./"$n" ;;
            *.gz)        gunzip ./"$n"      ;;
            *.cbz|*.epub|*.zip) unzip ./"$n"       ;;
            *.z)         uncompress ./"$n"  ;;
            *.7z|*.apk|*.arj|*.cab|*.cb7|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.wim|*.xar)
                         7z x ./"$n"        ;;
            *.xz)        unxz ./"$n"        ;;
            *.exe)       cabextract ./"$n"  ;;
            *.cpio)      cpio -id < ./"$n"  ;;
            *.cba|*.ace) unace x ./"$n"      ;;
            *.zpaq)      zpaq x ./"$n"      ;;
            *.arc)       arc e ./"$n"       ;;
            *.cso)       ciso 0 ./"$n" ./"$n.iso" && \
                              extract $n.iso && \rm -f $n ;;
            *)
                         echo "extract: '$n' - unknown archive method"
                         return 1
                         ;;
          esac
      else
          echo "'$n' - file does not exist"
          return 1
      fi
    done
fi
}

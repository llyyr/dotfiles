# This file is read each time a login shell is started.
# All other interactive shells will only read .bashrc; this is particularly
# important for language settings, see below.

export EDITOR=/usr/bin/nvim
export PATH="${HOME}/.local/bin:${PATH}"
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

alias vim=nvim
alias ls="ls -Ah --color=auto --group-directories-first"
alias mpa="mpv --profile=audio"
alias mvi="mpv --config-dir=/mnt/c/mvi/ $@"
alias grep="grep --color=auto --binary-files=without-match --devices=skip"
alias twitchclip="yt-dlp -o '%(creator)s-%(id)s.%(ext)s'"
alias twitterclip="yt-dlp -o '%(uploader_id)s-%(id)s.%(ext)s'"
alias yt-dlp-aria2c="yt-dlp --external-downloader aria2c --downloader-args 'aria2c:--continue true --retry-wait=30 -j 5 -x 5 -s 5 -k 1M'"
alias cp="cp -ip"
alias mv="mv -i"
alias rm="rm -i"
alias traffic="sudo ss -tp4"
alias windesktop="cd /mnt/c/Users/llyyr/Desktop/"
alias brplay="cd ~/.local/share/Steam/steamapps/compatdata/291550/pfx/drive_c/users/steamuser/BrawlhallaReplays"
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
alias gbf="chromium-browser --ozone-platform-hint=auto --disable-backgrounding-occluded-windows"
alias gbf2="microsoft-edge-beta --profile-directory='Profile 2' --ozone-platform-hint=auto --disable-backgrounding-occluded-windows"
alias gbf22="microsoft-edge-beta --profile-directory='Profile 3' --ozone-platform-hint=auto --disable-backgrounding-occluded-windows"
alias gbf23="microsoft-edge-beta --profile-directory='Profile 4' --ozone-platform-hint=auto --disable-backgrounding-occluded-windows"
#alias discord="discord --no-sandbox --disable-smooth-scrolling" 
alias discord-canary="discord-canary --no-sandbox --disable-smooth-scrolling" 
#alias discordtest="discord --no-sandbox --disable-smooth-scrolling --enable-features=UseOzonePlatform --ozone-platform=wayland"

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
    curl -F "file=@$1" https://0x0.st
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

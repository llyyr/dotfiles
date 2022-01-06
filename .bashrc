# This file is read each time a login shell is started.
# All other interactive shells will only read .bashrc; this is particularly
# important for language settings, see below.

export EDITOR=/usr/bin/nvim
export PATH="${HOME}/.local/bin:${PATH}"
#export LC_ALL=en_US.UTF-8
#export LANG=en_US.UTF-8
shopt -s autocd

HISTIGNORE="ls:bg:fg:exit:reset:clear:cd"
HISTCONTROL="ignoreboth:erasedups"
HISTSIZE=1000
HISTFILESIZE=2000
datetimefilename=$(date +'%Y%m%d-%H%M')

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
alias f="ag --smart-case --skip-vcs-ignores"
alias blank="sleep 1; xset dpms force off"
alias dotfiles="/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME"
alias localejp="LC_ALL=ja_JP.UTF-8 LANG=ja_JP.UTF-8"
alias cpug="sudo cpupower frequency-set -g $1"
alias runvenv="source env/bin/activate"
alias ghc="ghc -no-keep-hi-files -no-keep-o-files $1"
alias xpaste="xclip -selection clipboard -o"
alias xcopy="xclip -selection c"
#temp lol
alias gbf="chromium-browser --enable-features=UseOzonePlatform --ozone-platform=wayland"
alias gbf2="microsoft-edge-beta --enable-features=UseOzonePlatform --ozone-platform=wayland"
alias discord="discord --no-sandbox --disable-smooth-scrolling --enable-features=UseOzonePlatform --ozone-platform=wayland"
alias discord-canary="discord-canary --no-sandbox --disable-smooth-scrolling --enable-features=UseOzonePlatform --ozone-platform=wayland"

waylandrc() {
    #wf-recorder -g "$(slurp)" -c h264_vaapi -d /dev/dri/renderD128 --force-yuv -f ~/Videos/${datetimefilename}.mp4
    wf-recorder -g "$(slurp)" -f ~/Videos/${datetimefilename}.mp4
}

upload-file() {
    curl -F "file=@$1" https://0x0.st
}

mkcd() {
    test -d "$1" || mkdir "$1" && cd "$1"
}

wttr() {
    if [ -z $1 ]; then
        curl -s "v2.wttr.in"
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

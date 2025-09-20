set -Ux XDG_DATA_HOME "$HOME/.local/share"
set -Ux XDG_CONFIG_HOME "$HOME/.config"
set -Ux XDG_STATE_HOME "$HOME/.local/state"
set -Ux XDG_CACHE_HOME "$HOME/.cache"
set -Ux SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/ssh-agent.socket"
set -Ux EDITOR "/usr/bin/nvim"
set -Ux LC_ALL "en_US.UTF-8"
set -Ux LANG "en_US.UTF-8"
set -Ux ZYPP_MEDIANETWORK 1
set -Ux WINEDEBUG "-all"
set -Ux HISTSIZE 10000
set -Ux SAVEHIST 100000
set -Ux MAKEFLAGS "-j$(nproc)"
set -Ux NINJAFLAGS "-j$(nproc)"
set -x ASAN_OPTIONS "abort_on_error=1:disable_coredump=0"
set -x _JAVA_OPTIONS "-Dawt.useSystemAAFontSettings=gasp"

if test -f ~/.mesa_git_env
    source ~/.mesa_git_env
end

set -U fish_greeting
set -Ua fish_user_paths "$HOME/go/bin" "$HOME/.local/bin" "$HOME/.cargo/bin"
set -U fish_history_save_no_duplicates
set -U fish_history_merge_on_read

function fish_user_key_bindings
    bind \cc 'commandline -f cancel; printf "\n"; commandline ""; commandline -f repaint'
end

function fish_title
    echo -n ""
end

alias vim="$EDITOR"
alias lsd="lsd -AF --date=relative --icon=never --group-directories-first"
alias ls="lsd -AF --date=relative --icon=never --group-directories-first"
alias l="ls -l"
alias lt="ls --tree"
alias browse="fzf --bind='enter:execute(echo -n {} | wl-copy)' --preview='pygmentize {} 2>/dev/null || cat {}' --preview-window=up"
alias grep="grep --color=auto --binary-files=without-match --devices=skip"
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"
alias mpa="mpv --profile=audio"
alias cp="cp -ipv"
alias mv="mv -iv"
alias mkdir="mkdir -pv"
alias du="du -ach | sort -h"
alias df="df -hlT"
alias diff="diff -Naup --color=auto"
alias traffic="sudo ss -p4"
alias rg="rg --smart-case"
alias dotfiles="/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME"
alias localejp="env LC_ALL=ja_JP.UTF-8 LANG=ja_JP.UTF-8"
alias cpug="sudo cpupower frequency-set -g $argv[1]"
alias makevenv="python3 -m venv venv"
alias runvenv="source venv/bin/activate.fish"
alias ghc="ghc -no-keep-hi-files -no-keep-o-files $argv[1]"
alias pypy="/opt/pypy/bin/pypy"
alias rsync="rsync --info=progress2 --sparse --progress --human-readable"
alias adb="env HOME=$XDG_DATA_HOME/android adb"
alias wget="wget --hsts-file=$XDG_DATA_HOME/wget-hsts"

function colpick
    grim -g (slurp -p) -t ppm - | convert - -format '%[pixel:p{0,0}]' txt:-
end

function waylandrc
    wf-recorder -g (slurp) --audio -f ~/Videos/(date +'%Y%m%d-%H%M').mp4
end

function upload-yukari
    if test (count $argv) -eq 0
        curl -X POST -u "llyyr:$YUKARI_PASS" -s -F file=@- https://host.yukari.in/upload
    else
        curl -X POST -u "llyyr:$YUKARI_PASS" -s -F file=@$argv[1] https://host.yukari.in/upload
    end
end

function mkcd
    test -d $argv[1] || mkdir $argv[1]
    cd $argv[1]
end

function wttr
    if test -z $argv[1]
        curl -s "v2.wttr.in/Jamal+Patna"
    else
        curl -s "v2.wttr.in/$argv[1]"
    end
end

function cheat
    if test -z $argv[1]
        curl -s "cheat.sh"
    else
        curl -s "cheat.sh/$argv[1]"
    end
end

function ff
    set pattern $argv[1]
    set --erase argv[1]
    if test (count $argv) -eq 0
        set argv .
    end
    find $argv | grep -i -- $pattern
end

function man
    set -lx LESS_TERMCAP_md (printf '\e[1;36m')
    set -lx LESS_TERMCAP_me (printf '\e[0m')
    set -lx LESS_TERMCAP_us (printf '\e[1;32m')
    set -lx LESS_TERMCAP_ue (printf '\e[0m')
    set -lx GROFF_NO_SGR 1
    command man $argv
end

function n --wraps nnn --description 'support nnn quit and change directory'
    # Block nesting of nnn in subshells
    if test -n "$NNNLVL" -a "$NNNLVL" -ge 1
        echo "nnn is already running"
        return
    end

    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
    # see. To cd on quit only on ^G, remove the "-x" from both lines below,
    # without changing the paths.
    if test -n "$XDG_CONFIG_HOME"
        set -x NNN_TMPFILE "$XDG_CONFIG_HOME/nnn/.lastd"
    else
        set -x NNN_TMPFILE "$HOME/.config/nnn/.lastd"
    end

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    # The command function allows one to alias this function to `nnn` without
    # making an infinitely recursive alias
    command nnn $argv

    if test -e $NNN_TMPFILE
        source $NNN_TMPFILE
        rm -- $NNN_TMPFILE
    end
end

function rm
    for v in $argv
        if test -d $v
            ls $v
        end
    end
    command rm -Iv $argv
end

function fkill
    set pid
    if test $UID -ne 0
        set pid (ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
    else
        set pid (ps -ef | sed 1d | fzf -m | awk '{print $2}')
    end

    if test -n $pid
        echo $pid | xargs kill "-$argv[1]"
    end
end

function refenv
    export (tmux show-environment | grep "^SSH_AUTH_SOCK")
    export (tmux show-environment | grep "^SWAYSOCK")
    export (tmux show-environment | grep "^DISPLAY")
end

function genshin_wish
    set file (ls -d /home/llyyr/.local/share/anime-game-launcher/game/drive_c/Program\ Files/Genshin\ Impact/GenshinImpact_Data/webCaches/*/Cache/Cache_Data | sort -V | tail -n 1)
    strings "$file/data_2" | rg -o "https://.*/getGachaLog\?.*end_id=0" | tail -n 1
end

function wuwa_wish
    strings "/mnt/g/Wuthering Waves/Wuthering Waves Game/Client/Saved/Logs/Client.log" | rg -o "https://.*/record\?.*platform=PC"
end

function gli
    set -l gitLogLineToTitle "echo {} | grep -o '[a-f0-9]\\{12\\}' | head -1 | xargs git log -1 --pretty=format:'%s'"
    set -l gitLogLineToHash "echo {} | grep -o '[a-f0-9]\\{12\\}' | head -1 | xargs git rev-parse"
    set -l viewGitLogLine "$gitLogLineToHash | xargs -I % sh -c 'git show --color=always % | TERM=dumb delta --dark --color-only --diff-so-fancy --tabs=4'"
    set -l viewGitLogLineUnfancy "$gitLogLineToHash | xargs -I % sh -c 'git show % | delta --dark --color-only --diff-so-fancy --tabs=4'"

    git log --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr% C(auto)%an" $argv |
        fzf --no-sort --reverse --tiebreak=index --no-multi \
            --ansi --preview="$viewGitLogLine" \
            --header "enter to view, ctrl-y to copy hash, ctrl-v to open in nvim" \
            --bind "enter:execute:$viewGitLogLine   | less -R" \
            --bind "ctrl-v:execute:$viewGitLogLineUnfancy | nvim -" \
            --bind "ctrl-y:execute:$gitLogLineToHash | wl-copy" \
            --bind "ctrl-x:execute:$gitLogLineToTitle | wl-copy"
end

function cplast
    fc -ln -1 | wl-copy
end

function gdx
    gdb -ex 'set confirm off' -ex 'set height unlimited' -ex r -ex bt -ex q --args $argv
end

function ta
    if not tmux has-session -t 0 2>/dev/null
        tmux new-session -d -s 0 -n weechat weechat \; attach
        return
    end

    set clients (count (tmux list-clients -t 0))
    if test $clients -eq 0
        tmux attach
        return
    end

    tmux new-session -t 0 -s "0-$clients" \; set-option destroy-unattached on
end

if status is-interactive
    # Commands to run in interactive sessions can go here
end

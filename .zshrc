export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"
source ~/.mesa_git_env

typeset -U PATH path # ensure only unique entries in $PATH
path+="${HOME}/go/bin/"
path+="${HOME}/.local/bin/"
path+="${HOME}/.cargo/bin/"

# if [[ -O "${BASH_SOURCE[0]:-${(%):-%x}}" && $- == *i* && ! $VIM_TERMINAL ]] && [ -n "${DISPLAY}" ] && [ -z "${TMUX}" ]; then # && (SHLVL <3)
#   command tmux attach || command tmux
# fi

export EDITOR=/usr/bin/nvim
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export ZYPP_MEDIANETWORK=1
export WINEDEBUG=-all
# export DEBUGINFOD_URLS="https://debuginfod.opensuse.org/"
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"
source ~/.aliases
source ~/.secrets

export HISTSIZE=10000
export SAVEHIST=100000
export HISTFILE="$XDG_STATE_HOME/zsh/history"
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_reduce_blanks
setopt hist_ignore_space
setopt inc_append_history
setopt share_history

setopt auto_cd
setopt no_case_glob
unsetopt nomatch
unsetopt flowcontrol

unsetopt beep

KEYTIMEOUT=1

ZSH_AUTOSUGGEST_USE_ASYNC=true

zle_highlight[(r)suffix:*]="suffix:fg=foreground" # remove that annoying bold slash at the end of paths
autoload -U colors && colors	# Load colors

# Custom completion settings
setopt globdots
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"
zstyle ":completion:*:default" list-colors ${(s.:.)LS_COLORS} "ma=48;5;25;1"
zstyle ':completion:*' menu select
autoload -Uz compinit
compinit

fzf_colors='--color=gutter:regular:-1,bg:regular:-1,fg:regular:4,bg+:regular:-1,fg+:regular:2,hl:regular:3,hl+:regular:15,pointer:regular:5,prompt:regular:0,info:regular:3'
export FZF_DEFAULT_OPTS="$fzf_colors --pointer='█' --prompt='█ ' --reverse"

# fzf completion
# Only check once per session to avoid repeated directory checks
if [[ -z "$_FZF_TAB_LOADED" ]]; then
  if ! [ -d "$HOME/.config/zsh/fzf-tab" ]; then
    git clone https://github.com/Aloxaf/fzf-tab "$HOME/.config/zsh/fzf-tab"
  fi
  source $HOME/.config/zsh/fzf-tab/fzf-tab.plugin.zsh
  export _FZF_TAB_LOADED=1
fi

zstyle ':completion:*:git-checkout:*' sort false
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd -1 --color=always $realpath'
zstyle ':fzf-tab:*' default-color $'\033[0;10m' # else fg+ won't work (and maybe something else)
zstyle ':fzf-tab:*' fzf-flags --no-separator --info=hidden $fzf_colors

# zmodload zsh/zprof


setopt prompt_subst
if [ -r /usr/share/bash-completion/completions/git-prompt.sh ]; then
	. /usr/share/bash-completion/completions/git-prompt.sh
fi
export GIT_PS1_SHOWDIRTYSTATE=0
export GIT_PS1_SHOWUNTRACKEDFILES=0
export GIT_PS1_SHOWUPSTREAM="auto"

PS1="%B%F{blue}%~%f%b"\
$'$(__git_ps1 " %%F{212}%s%%f")'\
"%(?.. %B%F{red}%?%f%b)"\
$'\n%F{cyan}%(1j.+%j .)%f%F{yellow}❱❱❱%f '
PS2="... "

__git_files () {
    # git tab completion is really slow otherwise
    _wanted files expl 'local files' _files
}

# Fix special keys
bindkey "${terminfo[kpp]}" history-beginning-search-backward
bindkey "${terminfo[knp]}" history-beginning-search-forward
bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}" end-of-line
bindkey "${terminfo[kdch1]}" delete-char

bindkey '^[[A' history-beginning-search-backward
bindkey '^[[B' history-beginning-search-forward
bindkey '^T' history-incremental-search-forward

bindkey "^[[1;5C" forward-word  # ctrl-right
bindkey "^[[1;5D" backward-word  # ctrl-left
bindkey "^[[3;5~" kill-word  # ctrl-delete
bindkey "^[[H" beginning-of-line  # home
bindkey "^[[F" end-of-line  # end
bindkey "^[[3~" delete-char  # delete


# Make these a bit more like bash
bindkey "^U" backward-kill-line
bindkey '^[[Z' reverse-menu-complete

autoload edit-command-line
zle -N edit-command-line
bindkey '^E' edit-command-line

autoload -Uz copy-earlier-word
zle -N copy-earlier-word
bindkey '^[m' copy-earlier-word

# Don't blow up on URLs
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

fzf_history_search() {
  setopt extendedglob
  local ret=$?
  # Use fc directly without awk for better performance - zsh's fc already handles duplicates via hist_ignore_all_dups
  candidates=(${(f)"$(fc -n -l -1 0 | fzf +s +m -x -e --preview-window=hidden --no-info -q "$BUFFER")"})
  if [ -n "$candidates" ]; then
    BUFFER="${candidates[@]}"
    BUFFER=$(printf "${BUFFER[@]//\\\\n/\\\\\\n}")
    zle vi-fetch-history -n $BUFFER
  fi
  zle reset-prompt
  return $ret
}

autoload fzf_history_search
zle -N fzf_history_search

bindkey '^r' fzf_history_search

# # simple fuzzy history
# ::fuzzy_history() {
#   local output
#   output=$( \
#     history 1 \
#     | awk '{ $1=""; print substr($0,2) }' \
#     | fzf \
#       --query="$BUFFER" \
#       --bind change:first \
#       --tac \
#       --no-sort \
#       --no-info \
#       --reverse \
#       --bind=tab:down,shift-tab:up
#   )
#   echo "$output"
# }
#
# ::fuzzy_history::keybind() {
#   local output
#   output="$(::fuzzy_history)"
#   zle reset-prompt
#   if [ ! "$output" = "" ]; then
#     BUFFER=""             # clear whatever is on the line
#     LBUFFER+="${output//$'\n'/\\n}"  # append selection from fzf, keeping \n as is
#   fi
#   return 0
# }
#
# zle -N ::fuzzy_history::keybind
# bindkey -a "/" ::fuzzy_history::keybind
# bindkey "" ::fuzzy_history::keybind # <- much easier to press the up arrow on a 60%

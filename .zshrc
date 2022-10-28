typeset -U PATH path # ensure only unique entries in $PATH
path+="${HOME}/.dotnet/"
path+="${HOME}/.local/bin/"
path+="${HOME}/.cargo/bin/"


if [[ -O "${BASH_SOURCE[0]:-${(%):-%x}}" && $- == *i* && ! $VIM_TERMINAL ]] && [ -n "${DISPLAY}" ] && [ -z "${TMUX}" ]; then # && (SHLVL <3)
	command tmux attach || command tmux 
fi

export EDITOR=/usr/bin/nvim
export ZYPP_MEDIANETWORK=1
export WINEDEBUG=-all

eval $(dircolors ~/.dir_colors)
source ~/.aliases

# History in cache directory:
export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=100000
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_reduce_blanks
setopt hist_ignore_space
setopt inc_append_history
setopt share_history

setopt auto_cd
setopt no_case_glob
setopt nomatch

unsetopt beep # beep is the strongest warrior!

KEYTIMEOUT=1

zle_highlight[(r)suffix:*]="suffix:fg=foreground" # remove that annoying bold slash at the end of paths
autoload -U colors && colors	# Load colors

# Custom completion settings
setopt globdots
zstyle ":completion:*:default" list-colors ${(s.:.)LS_COLORS} "ma=48;5;25;1"
autoload -Uz compinit
compinit

fzf_colors='--color=gutter:regular:0,bg:regular:-1,fg:regular:4,bg+:regular:-1,fg+:regular:2,hl:regular:3,hl+:regular:15,pointer:regular:5,prompt:regular:0,info:regular:3'
export FZF_DEFAULT_OPTS="$fzf_colors --pointer='█' --prompt='█ ' --reverse"

# fzf completion
if ! [ -d "$HOME/.config/zsh/fzf-tab" ]; then
  git clone https://github.com/Aloxaf/fzf-tab "$HOME/.config/zsh/fzf-tab"
fi

source $HOME/.config/zsh/fzf-tab/fzf-tab.plugin.zsh

zstyle ':fzf-tab:*' default-color $'\033[0;10m' # else fg+ won't work (and maybe something else)
zstyle ':fzf-tab:*' fzf-flags --info=hidden $fzf_colors




setopt prompt_subst
if [ -r /usr/share/bash-completion/completions/git-prompt.sh ]; then
	. /usr/share/bash-completion/completions/git-prompt.sh
fi
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM="auto"

PS1="[%B%F{80}%n@%m%f%b]"\
"[%B%F{blue}%~%f%b]"\
$'$(__git_ps1 "[%%F{212}%s%%f]")'\
"%(?..[%B%F{red}%?%f%b])"\
$'\n%(?.%F{green}.%F{red})>%f%{\a%} '

PS2="... "

__git_files () {
    # git tab completion is really slow otherwise
    _wanted files expl 'local files' _files
}

# Update prompt before running commands
function _update-prompt {
    zle reset-prompt
    zle .accept-line
}

zle -N accept-line _update-prompt


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


# simple fuzzy history
::fuzzy_history() {
  local output
  output=$( \
    history 1 \
    | awk '{ $1=""; print substr($0,2) }' \
    | fzf \
      --query="$BUFFER" \
      --no-hscroll \
      --bind change:first \
      --tac \
      --no-sort \
      --height "15" \
      --no-info \
      --reverse \
      --bind=tab:down,shift-tab:up
  )
  echo "$output"
}

::fuzzy_history::keybind() {
  local output
  output="$(::fuzzy_history)"
  zle reset-prompt
  if [ ! "$output" = "" ]; then
    BUFFER=""             # clear whatever is on the line
    LBUFFER+="${output//$'\n'/\\n}"  # append selection from fzf, keeping \n as is
  fi
  return 0
}

zle -N ::fuzzy_history::keybind
bindkey -a "/" ::fuzzy_history::keybind
bindkey "" ::fuzzy_history::keybind # <- much easier to press the up arrow on a 60%

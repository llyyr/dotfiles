# This file is read each time a login shell is started.
# All other interactive shells will only read .bashrc; this is particularly
# important for language settings, see below.

export EDITOR=/usr/bin/nvim
export PATH="${HOME}/.dotnet/:${HOME}/.local/bin:${HOME}/.cargo/bin:${PATH}"
# export LC_ALL=en_US.UTF-8
# export LANG=en_US.UTF-8
shopt -s extglob
shopt -s autocd

# Load/launch tmux if the user owns this script, bash is interactive,
# the environment is not a Vim Terminal, and this is not a subshell.
if [[ -O "$BASH_SOURCE" && $- == *i* && ! $VIM_TERMINAL ]] && [ -n "${DISPLAY}" ] && [ -z "${TMUX}" ]; then # && (SHLVL <3)
	command tmux attach || command tmux 
fi

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUPSTREAM="auto"
PS1='$(__git_ps1 "\[\e[38;5;70m\]%s ")\[\e[1;32m\]\u@\h\[\e[1;34m\] \w \[\e[0m\]'

HISTIGNORE="ls:bg:fg:exit:reset:clear:cd"
HISTCONTROL="ignoreboth:erasedups"
HISTSIZE=1000
HISTFILESIZE=100000

export ZYPP_MEDIANETWORK=1
export WINEDEBUG=-all

eval $(dircolors ~/.dir_colors)
source ~/.aliases

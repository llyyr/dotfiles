git clone --bare https://github.com/llyyr/dotfiles $HOME/dotfiles

alias dotfiles='/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME'

dotfiles checkout

git clone --bare git@yourgit.example.com/dotfiles.git $HOME/dotfiles

alias dotfiles='/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME'

dotfiles checkout

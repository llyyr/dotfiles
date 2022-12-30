```
alias dotfiles='git --git-dir=$HOME/dotfiles --work-tree=$HOME'
```

# INIT
```
git init --bare $HOME/dotfiles
dotfiles config --local status.showUntrackedFiles no
```

# CLONE
```
git clone --bare https://github.com/llyyr/dotfiles $HOME/dotfiles
dotfiles config --local status.showUntrackedFiles no
dotfiles checkout
```


- Suo Sango cursor from [here](https://twitter.com/Yoruno_To_bari/status/1426339843995439105)

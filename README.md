# dotfiles
 My dotfiles config for vim/tmux/alacritty/yabai/skhd

## Easy Install:

1) Clone into home directory
```
cd ~
git clone https://github.com/jonnyjones99/dotfiles.git
```

2) Symlink files to the correct directory
```
ln -s ~/.dotfiles/.config/nvim ~/.config/nvim
```

### Stow
Rather than symlinking each file you can use GNU stow to quickly symlink the entire folder structure to .config.


## Other Things I use in my setup
- OhMyZsh
- LazyGit (https://github.com/jesseduffield/lazygit) <-- Must have for Git workflow 
- Powerlevel10k (https://github.com/romkatv/powerlevel10k) <-- Pretty looking terminal
- btop (https://github.com/aristocratos/btop) <-- Resource monitoring
- Neofetch (https://github.com/dylanaraps/neofetch) <-- :sunglasses:


### Alias' I use
```
alias sites='cd ~/Local\ Sites/'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias config='cd ~/.dotfiles'
```

Useful wordpress ones to jump around wp directory
```
alias wpRoot='cd ../../../../../'
alias intoTheme='cd app/public/wp-content/themes/'
```

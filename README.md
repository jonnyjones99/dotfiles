# dotfiles
My dotfiles config for [vim](https://neovim.io/)/[tmux](https://github.com/tmux/tmux/wiki)/[alacritty](https://github.com/alacritty/alacritty)/[yabai](https://github.com/koekeishiya/yabai)/[skhd](https://github.com/koekeishiya/skhd)

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

3) Nvim - Should auto install but if not
```
:Lazy -> 'I'
```

4) Tmux - install tpm packages
```
Ctrl + b -> 'I'
```

5) Nerd Font [JetBrainsMono](https://www.nerdfonts.com/font-downloads)


### [Stow](https://www.gnu.org/software/stow/)
Rather than symlinking each file you can use GNU stow to quickly symlink the entire folder structure to .config.


## Other Things I use in my setup
- OhMyZsh
- LazyGit (https://github.com/jesseduffield/lazygit)         <-- Must have for Git workflow 
- Powerlevel10k (https://github.com/romkatv/powerlevel10k)   <-- Pretty looking terminal
- btop (https://github.com/aristocratos/btop)                <-- Resource monitoring
- Neofetch (https://github.com/dylanaraps/neofetch)          <-- :sunglasses:
- Exa (https://github.com/ogham/exa)                         <-- Better LS command


### Alias' I use
```
alias sites='cd ~/Local\ Sites/'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias config='cd ~/.dotfiles'
alias ls='exa --icons --group-directories-first'
```

Useful wordpress ones to jump around wp directory
```
alias wpRoot='cd ../../../../../'
alias wpTheme='cd app/public/wp-content/themes/'
alias wpPlugin='cd app/public/wp-content/plugins/'
```

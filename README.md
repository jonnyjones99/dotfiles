# dotfiles
My dotfiles config for [vim](https://neovim.io/)/[tmux](https://github.com/tmux/tmux/wiki)/[alacritty](https://github.com/alacritty/alacritty)/[yabai](https://github.com/koekeishiya/yabai)/[skhd](https://github.com/koekeishiya/skhd)

<img width="1512" alt="React:Typescript Project" src="https://github.com/jonnyjones99/dotfiles/assets/72031997/51312d15-99fc-4d01-8041-2e95abfa2f97">

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

4) ZSH autocomplete/suggestions/syntax highlighting
```
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting && git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting && git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM/plugins/zsh-autocomplete
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

6) Download PHP stubs for intelphense (optional but useful for PHP work I have to do occasionally)
```
composer global require php-stubs/wordpress-globals php-stubs/wordpress-stubs php-stubs/woocommerce-stubs php-stubs/acf-pro-stubs wpsyntex/polylang-stubs php-stubs/genesis-stubs php-stubs/wp-cli-stubs
```


### [Stow](https://www.gnu.org/software/stow/)
Rather than symlinking each file you can use GNU stow to quickly symlink the entire folder structure to .config.


## Other Things I use in my setup
- OhMyZsh
- [LazyGit](https://github.com/jesseduffield/lazygit)                <-- Must have for Git workflow 
- [StarShip](https://starship.rs/)                                   <-- Better terminal prompts
- [btop](https://github.com/aristocratos/btop)                       <-- Resource monitoring
- [Neofetch](https://github.com/dylanaraps/neofetch)                 <-- :sunglasses:
- [Exa](https://github.com/ogham/exa)                                <-- Better LS command
- [BAT](https://github.com/sharkdp/bat)                              <-- Better CAT command
- [GitDelta](https://dandavison.github.io/delta/installation.html)   <-- Nice Git that uses Bat
- [FZF Git](https://github.com/junegunn/fzf-git.sh)                  <-- Nice FZF for git stuff
- [Gitmux](https://github.com/arl/gitmux)                            <-- Git in tmux status bar


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

### Troubleshooting
- `yabai: could not acquire lock-file! abort..`
-- `rm -rf /tmp/yabai*`
- Treesitter not highlighting
-- `TSEnable highlight`

#!/bin/bash

# Update
sudo apt update && sudo apt upgrade

# Setup xterm-kitty
tic -xe xterm-kitty ~/.config/xterm-kitty.terminfo

# Install zsh
sudo apt install zsh
chsh -s `which zsh`

# Setup zshrc
if [ "$1" == "remote" ]; then
    ZDOTDIR=~/.config/zshremote
else
    ZDOTDIR=~/.config/zsh
    touch ~/.hushlogin
fi
mv "$ZDOTDIR"/.zshenv ~/.zshenv

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Install neovim
sudo apt install neovim

# Install packer
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

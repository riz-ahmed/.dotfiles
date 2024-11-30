#! /bin/bash

brew install git
brew install wget
cd ~/Downloads
wget https://github.com/neovim/neovim/releases/download/v0.10.2/nvim-macos-arm64.tar.gz # download neovim
xattr -c ./nvim-macos* # remove developer not verified warning
brew install ripgrep
brew install fd
brew install node
brew install eza
brew install fzf
brew install bat
brew install black # python formatter
brew install bat-extras
brew install drpint # markdown formatter
python3 -m pip install python-lsp-server

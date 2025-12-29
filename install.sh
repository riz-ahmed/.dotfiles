#! /bin/bash

brew install git
brew install stow
brew install wget
brew install ripgrep
brew install fd
brew install node
brew install eza
brew install fzf
brew install bat
brew install black # python formatter
brew install bat-extras
brew install drpint # markdown formatter
brew install git-delta
brew install rsync
brew tap homebrew-zathura/zathura
brew install zathura
brew install zathura-pdf-mupdf
brew install zathura-cb
brew install zathura-djvu
brew install zathura-ps
d=$(brew --prefix zathura)/lib/zathura
mkdir -p $d
for n in cb djvu pdf-mupdf pdf-poppler ps; do
	p=$(brew --prefix zathura-$n)/lib$n.dylib
	[[ -f $p ]] && ln -s $p $d
done
curl https://raw.githubusercontent.com/homebrew-zathura/homebrew-zathura/refs/heads/master/convert-into-app.sh | sh

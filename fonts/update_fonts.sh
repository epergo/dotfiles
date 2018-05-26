#!/bin/bash

#################################################
# Download latest version of FuraCode Nerd font #
#################################################

set -u

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

rm $DIR/*.otf

wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Bold/complete/Fura%20Code%20Bold%20Nerd%20Font%20Complete.otf -P $DIR/
wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Light/complete/Fura%20Code%20Light%20Nerd%20Font%20Complete.otf -P $DIR/
wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Medium/complete/Fura%20Code%20Medium%20Nerd%20Font%20Complete.otf -P $DIR/
wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Regular/complete/Fura%20Code%20Regular%20Nerd%20Font%20Complete.otf -P $DIR/
wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Retina/complete/Fura%20Code%20Retina%20Nerd%20Font%20Complete.otf -P $DIR/

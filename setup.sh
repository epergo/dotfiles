#!/bin/bash

set -u

DEVELOPMENT="$HOME/development"
DEV_BIN="$DEVELOPMENT/bin"
DEV_WORKSPACES="$DEVELOPMENT/workspaces"
DOTFILES="$DEV_WORKSPACES/dotfiles"

print_step() {
  echo ""
  echo $1
  echo "--------------------------------------------------"
}

help() {
  cat << EOF
usage: $0 [OPTIONS]

  --help            Show this message
  --initial         Install all basic stuff
  --alacritty       Install alacritty terminal emulator
EOF
}

initial() {
  clear
  print_step "Type your sudo password"
  sudo -v

  print_step "Update your system"
  sudo apt update -qq
  sudo apt full-upgrade -y

  print_step "Install packages"
  sudo apt install -y git curl tig fasd vim \
    byobu zsh gnome-tweaks arc-theme \
    rustc cargo erlang cmake libfreetype6-dev \
    libfontconfig1-dev xclip numix-icon-theme-circle jq \
    fonts-firacode

  sudo apt autoremove && sudo apt autoclean

  mkdir -p $DEV_BIN $DEV_WORKSPACES

  print_step "Copy manually your ssh key to ~/.ssh"
  read -p "Press enter to continue when ready"

  chmod go-r .ssh/id_rsa.pub
  chmod go-r .ssh/id_rsa

  ssh-add

  print_step "Clone epergo/dotfiles"
  git clone git@github.com:epergo/dotfiles.git $DOTFILES

  print_step "Link config files/directories"
  ln -s $DOTFILES/vim/vimrc ~/.vimrc
  ln -s $DOTFILES/.gitconfig ~/.gitconfig
  ln -s $DOTFILES/.zshrc ~/.zshrc

  rm ~/.byobu/.tmux.conf
  ln -s $DOTFILES/.tmux.conf ~/.byobu/.tmux.conf

  print_step "Install ASDF"
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.4.3

  print_step "Install FZF"
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf

  print_step "Install Oh My ZSH"
  git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
  chsh -s $(which zsh)
}

alacritty () {
  sudo -v

  print_step "Install Alacritty"
  git clone git@github.com:jwilm/alacritty.git ~/.alacritty

  cd ~/.alacritty
  cargo build --release

  sudo cp ~/.alacritty/target/release/alacritty /usr/local/bin/alacritty
  cp $DOTFILES/alacritty/Alacrity.desktop ~/.local/share/applications/Alacrity.desktop
  cp $DOTFILES/alacritty/alacritty.yml $HOME/.config/alacritty/alacritty.yml
}

for opt in "$@"; do
  case $opt in
    --help)
      help
      exit 0;;
    --initial)
      initial
      exit 0;;
    --alacritty)
      alacritty
      exit 0;;
    *)
      "Unknow option, try --help"
      exit 1;;
  esac
done

help

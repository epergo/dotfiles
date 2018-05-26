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
  --keybase         Install keybase
EOF
}

initial() {
  clear
  print_step "Type your sudo password"
  sudo -v

  print_step "Update your system"
  sudo apt update -qq
  print_step "Add Numix icon theme"
  sudo add-apt-repository -y ppa:numix/ppa > /dev/null 2>&1
  print_step "Upgrade packages"
  sudo apt full-upgrade -y

  print_step "Install new packages"
  sudo apt install -y git curl tig fasd vim \
    byobu zsh gnome-tweaks arc-theme \
    rustc cargo erlang cmake libfreetype6-dev \
    libfontconfig1-dev xclip numix-icon-theme-circle jq \
    font-manager chrome-gnome-shell

  sudo apt autoremove && sudo apt autoclean

  mkdir -p $DEV_BIN $DEV_WORKSPACES

  print_step "Copy manually your ssh key to $HOME/.ssh"
  read -p "Press enter to continue when ready"

  chmod 600 .ssh/id_rsa.pub .ssh/id_rsa

  ssh-add

  print_step "Clone epergo/dotfiles"
  git clone git@github.com:epergo/dotfiles.git $DOTFILES

  print_step "Link config files/directories"
  ln -s $DOTFILES/vim/vimrc $HOME/.vimrc
  ln -s $DOTFILES/.gitconfig $HOME/.gitconfig
  ln -s $DOTFILES/.zshrc $HOME/.zshrc

  mkdir -p $HOME/.byobu
  ln -s $DOTFILES/.tmux.conf $HOME/.byobu/.tmux.conf

  print_step "Install ASDF"
  git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf --branch v0.4.3

  print_step "Install FZF"
  git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf

  print_step "Install Oh My ZSH"
  git clone https://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh
  chsh -s $(which zsh)
}

alacritty () {
  sudo -v

  print_step "Install Alacritty"
  git clone git@github.com:jwilm/alacritty.git $HOME/.alacritty

  rm -rf $HOME/.cargo/registry/index/*
  cd $HOME/.alacritty
  cargo build --release

  sudo cp $HOME/.alacritty/target/release/alacritty /usr/local/bin/alacritty
  cp $DOTFILES/alacritty/Alacrity.desktop $HOME/.local/share/applications/Alacrity.desktop

  mkdir -p $HOME/.config/alacritty/
  cp $DOTFILES/alacritty/alacritty.yml $HOME/.config/alacritty/alacritty.yml
}

keybase () {
  sudo -v

  print_step "Install Keybase"
  curl -O https://prerelease.keybase.io/keybase_amd64.deb
  sudo dpkg -i keybase_amd64.deb
  sudo apt-get install -f -y
  rm keybase_amd64.deb
  run_keybase
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
    --keybase)
      keybase
      exit 0;;
    *)
      "Unknow option, try --help"
      exit 1;;
  esac
done

help

#!/usr/bin/env bash

set -euo pipefail;

command_exists () {
  command -v $1 &> /dev/null;
}

is_fedora () {
  command_exists 'dnf';
}

is_arch () {
  command_exists 'pacman';
}

is_debian () {
  command_exists 'apt';
}

install_packages () {
  sudo $1 install ${PACKAGES[*]};
}

install_antigen () {
  curl -L git.io/antigen > $HOME/.config/zsh/antigen.zsh;
}

# Dependencies for programs configured by this repository
PACKAGES=(
  'emacs'
  'git'
  'neovim'
  'tmux'
  'zsh'
);

COMMAND='';

if is_fedora;
then
  COMMAND='dnf';
elif is_arch;
then
  COMMAND='pacman';
elif is_debian;
then
  COMMAND='apt';
fi

mkdir -p $HOME/.config/zsh;

install_packages $COMMAND;
install_antigen;

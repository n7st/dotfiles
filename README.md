# dotfiles

This repository contains configuration for my personal development environment.

## Prerequisites

The following Linux distributions are supported:

* Fedora (primarily)
* Debian
* Arch

## Configurations

* [Emacs](./configs/emacs/)
* [tmux](./configs/tmux/)
* [Z Shell](./configs/zsh/)

## Installation

The required dependencies can be installed using `./scripts/install-prerequisites.sh` (or `make install_prerequisites` if
you have `make` installed).

Presently, the configurations must be manually symlinked to their correct destinations (see
[#1](https://github.com/n7st/dotfiles/issues/1)).

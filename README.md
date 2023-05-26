# Dotfiles

Uses the [`git --bare`](https://www.atlassian.com/git/tutorials/dotfiles) strategy for keeping user dotfiles source controlled.

## Setup

    curl -L https://raw.githubusercontent.com/jamespamplin/dotfiles/master/setup.sh | bash

## Usage

    # use `config` as git alias to perform usual git commands on the dotfiles repo
    config status
    config add
    config commit
    config push

## Editing in vscode

    # use `dotfiles` alias to set git environment for editing with vscode
    dotfiles code ~

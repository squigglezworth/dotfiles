#!/bin/bash
set -e

if [ ! fzf ]; then
    git clone -q --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
    $HOME/.fzf/install --all; echoDone
else
    echo "fzf already installed, skipping!"
fi

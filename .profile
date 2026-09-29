#!/bin/sh
if [ -r /etc/profile ]; then
    . /etc/profile
fi
cd "$HOME" || exit 1
clear
if [ -r "$HOME/README.txt" ]; then
    cat "$HOME/README.txt"
else
    echo "This level is still being built."
    echo "Run 'cat README.txt' after the level becomes ready."
fi

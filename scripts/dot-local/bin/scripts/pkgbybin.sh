#!/bin/bash
# Prints package info by binary using pacman.
if [ -z $1 ]; then echo "Usage: $(basename $0) [BINARY NAME]"; exit 1; fi
binname=$(which $1) || exit 2
pkgname=$(pacman -Qoq $binname) || exit 3
pacman -Qi $pkgname

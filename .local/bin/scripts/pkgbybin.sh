#!/bin/bash
# Prints package info by binary using pacman.
if [ -z $1 ]; then echo "Usage: $(basename $0) [BINARY NAME]"; exit 1; fi
binname=$(which $1)
if [ $? -ne 0 ]; then echo $binname; exit 2; fi
pkgname=$(pacman -Qoq $binname)
if [ $? -ne 0 ]; then echo $pkgname; exit 3; fi
pacman -Qi $pkgname

#!/bin/bash
if [ $(pidof $1) ]; then
    $2
fi

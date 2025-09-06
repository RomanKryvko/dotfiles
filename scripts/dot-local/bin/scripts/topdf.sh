#!/bin/env bash

function help() {
    echo "Usage: $(basename $0) [args]
-h, --help          print this help message
-o, --outdir        set output directory
-d, --maxdepth      set max depth for file conversion
-c, --clean         remove files after conversion
"
}

function main() {
    local OUTDIR=$PWD
    local MAXDEPTH=1

    while [[ $# -gt 0 ]]; do
        case $1 in
            --help | -h)
                help
                exit 1
                ;;

            --outdir | -o)
                if [ ! -z $2 ] && [ ! -f $2 ]; then
                    OUTDIR=$2
                    shift
                else
                    help
                    exit 2
                fi
                shift
                ;;

            --maxdepth | -d)
                if [ ! -z $2 ] && [[ $2 =~ ^\d+$ ]]; then
                    MAXDEPTH=$2
                    shift
                else
                    help
                    exit 2
                fi
                shift
                ;;

            --clean | -c)
                CLEAN=1
                shift
                ;;

            *)
                help
                exit 3
                shift
                ;;
        esac
    done

    mkdir -p $OUTDIR

    find . -maxdepth $MAXDEPTH -type f \( -name "*.doc*" -o -name "*.ppt*" \) \
        -exec libreoffice --headless --convert-to pdf {} --outdir $OUTDIR \;

    if [[ $CLEAN ]]; then
        find . -maxdepth $MAXDEPTH -type f \( -name "*.doc*" -o -name "*.ppt*" \) \
            -exec rm {} +
    fi
}

main $@

#!/bin/bash

COMMAND=$1
VERSION=$(cat version.txt)

case $COMMAND in
    'version')
        echo "x=$VERSION + 0.01; if(x<1) print 0; x" | bc | tee version.txt
        ;;

esac
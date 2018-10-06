#!/bin/bash

COMMAND=$1
VERSION=$(cat version.txt)

updateVersion() {
    git checkout master && git pull
    echo "x=$VERSION + 0.01; if(x<1) print 0; x" | bc | tee version.txt
    git add . && git commit -m version
}

dockerize() {
    docker build .
}

case $COMMAND in
    'version')
        updateVersion
        ;;
    'dockerize')
        dockerize
        ;;

esac

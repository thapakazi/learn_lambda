#!/bin/bash

init(){
    mkdir -p bin/
}

get_slacktee(){
    SLACKTEE_SH_BIN=bin/slacktee
    curl https://github.com/coursehero/slacktee/raw/master/slacktee.sh \
         -sL -o $SLACKTEE_SH_BIN
    chmod +x $SLACKTEE_SH_BIN
}

build_bin(){
    init
    get_slacktee
    #TODO: get pg_dump bin & so file
    #TODO: get aws cli bins
}

print_out(){
    tree bin
}

build_bin
print_out

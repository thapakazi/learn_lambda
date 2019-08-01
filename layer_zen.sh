#!/bin/bash

set -e
init(){
    mkdir -p bin/
}

get_slacktee(){
    SLACKTEE_SH_BIN=bin/slacktee
    curl https://github.com/coursehero/slacktee/raw/master/slacktee.sh \
         -sL -o $SLACKTEE_SH_BIN
    chmod +x $SLACKTEE_SH_BIN
}

get_layers(){
    get_awscli
}

get_awscli(){
    cd gen && bash awscli.sh
}

build_bin(){
    init
    #get_slacktee
    get_layers
    #TODO: get pg_dump bin & so file
    #TODO: get aws cli bins
}

print_out(){
    tree bin
}

build_bin
print_out

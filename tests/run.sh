#!/bin/sh
: "${VIM_EXE:=vim}"

# Open vim with readonly mode just to execute all *.vader tests.
$VIM_EXE -Nu vimrc -R '+Vader! *.vader'

#! /bin/sh

guile --r7rs -L src -s src/sherry/main.scm --version | grep -E -q '[0-9]+([.][0-9]+)'

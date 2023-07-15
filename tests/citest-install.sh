#! /bin/sh

set -e

make --silent install
sherry --version 1>/dev/null

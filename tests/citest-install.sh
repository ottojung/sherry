#! /bin/sh

set -e

sudo make --silent install
sherry --version 1>/dev/null

#! /bin/sh

set -x

git reset --hard
git clean -df
git submodule foreach git reset --hard
git submodule foreach git clean -df

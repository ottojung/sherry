#! /bin/sh

set -e

mkdir -p dist
cp tests/data/outdatedfile1.scm dist/test-update-copy1

diff -q tests/data/outdatedfile1.scm dist/test-update-copy1

guile --r7rs -L src -s src/sherry/main.scm update-license -- tests/data/outdatedfile1.scm 2>/dev/null

if diff -q tests/data/outdatedfile1.scm dist/test-update-copy1 1>/dev/null 2>/dev/null
then
    cp dist/test-update-copy1 tests/data/outdatedfile1.scm
    exit 1
else
    cp dist/test-update-copy1 tests/data/outdatedfile1.scm
    exit 0
fi

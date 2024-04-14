#! /bin/sh

set -e

mkdir -p dist
cp tests/data/nolicensefile1.scm dist/test-update-2-copy.scm

diff -q tests/data/nolicensefile1.scm dist/test-update-2-copy.scm

guile --r7rs -L src -s src/sherry/main.sld --quiet update license -- tests/data/nolicensefile1.scm 2>/dev/null

if diff -q tests/data/nolicensefile1.scm dist/test-update-2-copy.scm 1>/dev/null 2>/dev/null
then
    cp dist/test-update-2-copy.scm tests/data/nolicensefile1.scm
    exit 1
else
    cp dist/test-update-2-copy.scm tests/data/nolicensefile1.scm
    exit 0
fi

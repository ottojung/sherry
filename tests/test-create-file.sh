#! /bin/sh

TOP="$PWD"

mkdir -p dist
rm -rf dist/create-test
cp -r tests/data dist/create-test
cd dist/create-test
guile --r7rs -L "$TOP/src" -s "$TOP/src/sherry/main.sld" create-file -- 'number->pokemon'

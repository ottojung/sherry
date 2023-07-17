#! /bin/sh

TOP="$PWD"

mkdir -p dist
rm -rf dist/to-program-test
cp -r tests/data dist/to-program-test
cd dist/to-program-test
guile --r7rs -L "$TOP/src" -s "$TOP/src/sherry/main.sld" --quiet r7rs-library to r7rs-program -- "lib1.scm"
diff "lib1.scm" "lib1-to-program-expected.scm"

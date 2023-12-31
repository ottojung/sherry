#! /bin/sh

RESULT=$(guile --r7rs -L src -s src/sherry/main.sld --quiet get exports -- tests/data/testfile1.scm)

case "$RESULT" in
    "(make-yearsrange yearsrange? yearsrange-start yearsrange-end)")
        true ;;
    *)
        printf "GOT:\n%s\n" "$RESULT" 1>&2
        echo "But expected a different license" 1>&2
        exit 1
        ;;
esac

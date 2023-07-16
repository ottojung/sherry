#! /bin/sh

RESULT=$(guile --r7rs -L src -s src/sherry/main.sld minify-license --print -- tests/data/testfile1.scm)

case "$RESULT" in
    ";;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.")
        true ;;
    *)
        printf "GOT:\n%s\n" "$RESULT" 1>&2
        echo "But expected a different license" 1>&2
        exit 1
        ;;
esac

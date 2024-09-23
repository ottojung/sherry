#! /bin/sh

# This script is needed because Sherry `watch` command executes `load`.
# The loaded code must not use Sherry's libraries, such as `euphrates`.

set -e

ROOT="$PWD"

FROM="euphrates"
TO="mdt6kfycrtnhzq31k1wsoqcrpfnyox0w-euphrates"

TMPNAME=$(cat /dev/urandom | base32 | head -c 10)
TMP="/tmp/my-czempak-rename-$TMPNAME"

cleanup() {
    rm -r -f -- "$TMP"
}

trap "cleanup" EXIT INT TERM HUP KILL

mv -v -- "src/$FROM" "src/$TO"
cd -- "$ROOT"/src/"$TO"

find -- . -type f -not -path '*/.*' | while IFS= read -r FILE
do
	NEWNAME="$(printf '%s' "$FILE" | sed -e "s#$FROM#$TO#g")"
	if ! test "$FILE" = "$NEWNAME"
	then mv -v -- "$FILE" "$NEWNAME"
	fi

	sed -e "s#$FROM#$TO#g" -- "$NEWNAME" > "$TMP"
	if ! diff -q -- "$NEWNAME" "$TMP"
	then cp -- "$TMP" "$NEWNAME"
	fi
done

cd -- "$ROOT"/src/sherry

find -- . -type f -not -path '*/.*' | while IFS= read -r FILE
do
	NEWNAME="$(printf '%s' "$FILE" | sed -e "s#$FROM#$TO#g")"
	if ! test "$FILE" = "$NEWNAME"
	then mv -v -- "$FILE" "$NEWNAME" || true
	fi

	sed -e "s#$FROM#$TO#g" -- "$NEWNAME" > "$TMP"
	if ! diff -q -- "$NEWNAME" "$TMP"
	then cp -- "$TMP" "$NEWNAME"
	fi
done

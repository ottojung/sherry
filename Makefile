
PREFIX="/usr/local"
PREFIXBIN="$(PREFIX)/bin"
PREFIXSHARE="$(PREFIX)/share"

SUBMODULES = deps/euphrates/README.md

all: build

# install:
# 	guile --r7rs -L src -s src/sherry/main.scm install-program \
# 		--main src/sherry/main.scm \
# 		--binary-name sherry \
# 		--project-name sherry \
# 		--src src \
# 		--prefix-share $(PREFIXSHARE) \
# 		--prefix-bin $(PREFIXBIN) \

build: $(SUBMODULES)
	sh tests/test-version.sh

install: build
	sh scripts/alpha-convert-euphrates.sh
	PREFIX=$(PREFIX) guile --r7rs -L src -s src/sherry/main.sld install program --project-name sherry
	sh scripts/reset-code.sh
	$(PREFIXBIN)/sherry --version 1>/dev/null

uninstall:
	rm -f -- $(PREFIXBIN)/sherry
	rm -rf -- $(PREFIXSHARE)/sherry

test: build
	sh scripts/run-tests.sh

$(SUBMODULES):
	git submodule update --init

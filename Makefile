
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
	guile --r7rs -L src -s src/sherry/main.scm \
		install-program \
		--prefix-share $(PREFIXSHARE) \
		--prefix-bin $(PREFIXBIN) \

test: build
	sh scripts/run-tests.sh

$(SUBMODULES):
	git submodule update --init

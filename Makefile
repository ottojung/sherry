
PREFIX="/usr/local"
PREFIXBIN="$(PREFIX)/bin"
PREFIXSHARE="$(PREFIX)/share"

all:

# install:
# 	guile --r7rs -L src -s src/sherry/main.scm install-program \
# 		--main src/sherry/main.scm \
# 		--binary-name sherry \
# 		--project-name sherry \
# 		--src src \
# 		--prefix-share $(PREFIXSHARE) \
# 		--prefix-bin $(PREFIXBIN) \

install:
	guile --r7rs -L src -s src/sherry/main.scm \
		install-program \
		--prefix-share $(PREFIXSHARE) \
		--prefix-bin $(PREFIXBIN) \

test:
	sh scripts/run-tests.sh

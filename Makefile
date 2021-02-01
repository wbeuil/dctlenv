all: test

test: bats
	$(PWD)/test/libs/bats-core/bin/bats test

bats:
	if [ ! -d "$(PWD)/test/libs/bats-core" ]; then \
		echo "Installing bats-core and its plugins"; \
		git clone https://github.com/bats-core/bats-core.git test/libs/bats-core; \
		git clone https://github.com/ztombol/bats-assert test/libs/bats-assert; \
		git clone https://github.com/ztombol/bats-support test/libs/bats-support; \
	fi

.SILENT: test bats
.PHONY: test bats

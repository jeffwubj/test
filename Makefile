ifeq (, $(shell which go))
$(error Install Go - https://golang.org/dl/ )
endif

INSTALL_DIR=/usr/local/bin
BIN_DIR=./bin
NATIVE_ARCH=$(shell uname | tr A-Z a-z)

GOARCH=amd64
OSES=linux darwin windows
BUILD_TARGETS=$(foreach os,$(OSES),$(BIN_DIR)/$(os)/test)

.PHONY: clean
clean:
	-rm -rf $(BIN_DIR)

.PHONY: dist
dist: clean $(BUILD_TARGETS)

$(BIN_DIR)/%/test:
	GOOS=$* go build -o $@ ./main.go

.PHONY: build
build: $(BIN_DIR)/$(NATIVE_ARCH)/test 

.PHONY: install
install: $(BIN_DIR)/$(NATIVE_ARCH)/test 
	cp $(BIN_DIR)/$(NATIVE_ARCH)/test $(INSTALL_DIR)

.PHONY: all
all: clean build install

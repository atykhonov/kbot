VERSION := $(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)

# .PHONY: set-arch
# set-arch:
#	@echo "Architecture set to $(call initArch)"

# .PHONY: set-arch
# set-arch:
# 	$(eval ARCH := $(shell $(call initArch)))
#	@echo "Architecture set to $(ARCH)"

APP=$(shell basename $(shell git remote get-url origin) .git)

VERSION=$(shell git describe --tags --always --long)
LD_FLAGS="-s -w -X github.com/atykhonov/kbot/cmd.appVersion=${VERSION}"
TARGET_OS=linux
TARGET_ARCH=amd64
REGISTRY=localhost:5000
IMAGE_TAG=$(REGISTRY)/$(APP):$(VERSION)-$(TARGET_ARCH)
GO_BUILD_OUTPUT=kbot

.PHONY: all test clean

version:
	@echo "Version: $(VERSION)"

app:
	@echo "App: $(APP)"

all: test build

format:
	gofmt -s -w ./

lint:
	golint

test:
	go test -v

get:
	go get

PHONY: build
build: format get
	CGO_ENABLED=0 GOOS=$(TARGET_OS) GOARCH=$(TARGET_ARCH) go build -o $(GO_BUILD_OUTPUT) -ldflags $(LD_FLAGS) -v

image:
	docker build . -t $(IMAGE_TAG)

push:
	docker push $(IMAGE_TAG)

clean:
	rm -rf $(APP)
	rm -rf $(APP)_*
	go clean
	docker rmi $(IMAGE_TAG) || true

linux:
	make build TARGET_OS=linux GO_BUILD_OUTPUT=$(APP)_linux_amd64

arm:
	make build TARGET_OS=linux GO_BUILD_OUTPUT=$(APP)_linux_arm

macos:
	make build TARGET_OS=darwin GO_BUILD_OUTPUT=$(APP)_darwin_amd64

windows:
	make build TARGET_OS=windows GO_BUILD_OUTPUT=$(APP)_windows_amd64.exe
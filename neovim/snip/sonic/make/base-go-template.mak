.DEFAULT_GOAL := build

.PHONY: fmt
fmt:
	go fmt

.PHONY: lint
lint:
	staticcheck

.PHONY: vet
vet: fmt
	go vet

.PHONY: build
build: vet
	go mod tidy
	go build

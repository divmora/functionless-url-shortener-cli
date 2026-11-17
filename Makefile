.PHONY: all build test lint clean

all: lint test build

build:
	go build -o bin/shorten ./cmd/shorten

test:
	go test ./...

lint:
	golangci-lint run ./...

clean:
	rm -rf bin/ dist/

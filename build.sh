#!/usr/bin/env bash
set -x
rm -rf build
mkdir build

go clean
go test ./...

GOOS=linux  GOARCH=amd64 go build -v -o build/goFileServer_linux64   goFileServer.go
GOOS=linux  GOARCH=arm64 go build -v -o build/goFileServer_arm64     goFileServer.go
GOOS=darwin GOARCH=amd64 go build -v -o build/goFileServer_mac64     goFileServer.go
GOOS=darwin GOARCH=arm64 go build -v -o build/goFileServer_mac_arm64 goFileServer.go

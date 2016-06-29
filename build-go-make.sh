#!/bin/bash -ex

VERSION=1.6.2

if ! [ -d $HOME/go ]; then
  curl -sSL https://storage.googleapis.com/golang/go${VERSION}.linux-amd64.tar.gz | tar -C $HOME -xz
fi

export GOROOT=$HOME/go
export PATH=$PATH:$GOROOT/bin

export GOPATH=$HOME/work
export PATH=$GOPATH/bin:$PATH

rm -rf $GOPATH

mkdir -p $GOPATH/src/github.com/BurntSushi
cd $GOPATH/src/github.com/BurntSushi
git clone --depth 1 https://github.com/BurntSushi/toml
cd toml

go install ./...
go get github.com/BurntSushi/toml-test
make test

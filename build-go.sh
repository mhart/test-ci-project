#!/bin/bash -ex

VERSION=1.6.2

if ! [ -d $HOME/go ]; then
  curl -sSL https://storage.googleapis.com/golang/go${VERSION}.linux-amd64.tar.gz | tar -C $HOME -xz
fi

export GOROOT=$HOME/go
export PATH=$PATH:$GOROOT/bin

cd /tmp
rm -rf hob

git clone --depth 1 https://github.com/mrb/hob

cd hob

export GOPATH=$PWD

go get github.com/bmizerany/assert
go get github.com/mrb/hob
go test


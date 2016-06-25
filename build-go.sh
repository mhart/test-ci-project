#!/bin/bash -ex

TARBALL=go1.6.2.linux-amd64.tar.gz

if ! [ -d $HOME/go ]; then
  curl -sSL https://storage.googleapis.com/golang/${TARBALL} -o /tmp/${TARBALL}
  tar -C $HOME -xzf /tmp/${TARBALL}
  rm -f /tmp/${TARBALL}
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

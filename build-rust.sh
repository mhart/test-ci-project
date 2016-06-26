#!/bin/bash -ex

export CARGO_HOME=$HOME/.cargo
export MULTIRUST_HOME=$HOME/.multirust
export RUSTUP_HOME=$HOME/.multirust/rustup

curl https://sh.rustup.rs -sSf | sh -s -- -y

export PATH=$HOME/.cargo/bin:$PATH

cd /tmp
rm -rf bitflags

git clone --depth 1 https://github.com/rust-lang-nursery/bitflags

cd bitflags

cargo build --verbose
cargo test --verbose

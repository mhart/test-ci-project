#!/bin/bash -ex

# Clone an example Rust repo
# This step obviously won't be necessary if you're building a Rust repo with LambCI,
# because you'll already be in the cloned repo directory
rm -rf /tmp/bitflags
git clone --depth 1 https://github.com/rust-lang-nursery/bitflags /tmp/bitflags
cd /tmp/bitflags


# Begin the Rust bootstrapping process

export CARGO_HOME=$HOME/.cargo
export MULTIRUST_HOME=$HOME/.multirust
export RUSTUP_HOME=$HOME/.multirust/rustup

curl https://sh.rustup.rs -sSf | sh -s -- -y

export PATH=$HOME/.cargo/bin:$PATH


# Now we can run our project's install and test steps

cargo build --verbose
cargo test --verbose

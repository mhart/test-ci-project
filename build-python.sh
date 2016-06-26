#!/bin/bash -ex

curl -sSLO https://bootstrap.pypa.io/get-pip.py
python get-pip.py --user

export PATH=$HOME/.local/bin:$PATH

git clone --depth 1 https://github.com/pytest-dev/pytest

cd pytest

pip install --user -U tox

tox --recreate -e py27


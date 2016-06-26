#!/bin/bash -ex

git clone --depth 1 https://github.com/pytest-dev/pytest

cd pytest

pip install --user -U tox

tox --recreate -e py27


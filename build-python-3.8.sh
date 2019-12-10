#!/bin/bash -ex

# Clone an example Python repo
# This step obviously won't be necessary if you're building a Python repo with LambCI,
# because you'll already be in the cloned repo directory
rm -rf /tmp/pendulum
git clone -b 2.0.4 --depth 1 https://github.com/sdispater/pendulum /tmp/pendulum
cd /tmp/pendulum


# You could just put this in your `cmd` config property
. ~/init/python 3.8.0
curl -sSL https://raw.githubusercontent.com/sdispater/poetry/0.12.10/get-poetry.py | POETRY_VERSION=0.12.10 python
pyenv rehash
. ~/.poetry/env
poetry install -v && poetry build -v && poetry run pytest tests/ -W ignore

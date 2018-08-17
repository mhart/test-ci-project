#!/bin/bash -ex

# Clone an example PHP repo
# This step obviously won't be necessary if you're building a PHP repo with LambCI,
# because you'll already be in the cloned repo directory
rm -rf /tmp/chronos
git clone --depth 1 https://github.com/cakephp/chronos /tmp/chronos
cd /tmp/chronos


# You could just put this in your `cmd` config property
. ~/init/php && composer install -n --prefer-dist && vendor/bin/phpunit

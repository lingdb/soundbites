#!/bin/bash
# This script will fill the output folder as good as it can.
# Give the target to fetch information from as $1.
# Finding output directory:
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
output="$dir/output"
# Copying static from submodule:
rsync -r --progress ../soundcomparisons/soundcomparisons/static $output
# Fetching content from url:
wget "$1" -O $output/index.html

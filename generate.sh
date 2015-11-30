#!/bin/bash
# This script will fill the output folder as good as it can.
# Give the target to fetch information from as $1.
# Finding output directory:
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
output="$dir/output"
# Copying static from submodule:
rsync -r --progress soundcomparisons/soundcomparisons/static $output
# Fetching index.html from url:
wget "$1" -O $output/index.html
# Creating data directory:
mkdir -p $output/data
# Fetching data:
declare -A fetchMe
fetchMe=(["query/data"]="data"
         ["query/data?global"]="data_global_null"
         ["query/data?study=Andean"]="data_study_Andean"
         ["query/data?study=Celtic"]="data_study_Celtic"
         ["query/data?study=Englishes"]="data_study_Englishes"
         ["query/data?study=Germanic"]="data_study_Germanic"
         ["query/data?study=Mapudungun"]="data_study_Mapudungun"
         ["query/data?study=Quechua"]="data_study_Quechua"
         ["query/data?study=Romance"]="data_study_Romance"
         ["query/data?study=Slavic"]="data_study_Slavic"
         ["query/templateInfo"]="templateInfo"
         ["query/translations?action=summary"]="translations_action_summary"
         ["query/translations?lng=en+de+es+ru+pt&ns=translation"]="translations_i18n")
for src in "${!fetchMe[@]}"; do
  dst="${fetchMe[$src]}"
  echo "Fetching $src -> $dst"
  wget "$1/$src" -O "$output/data/$dst"
done
# Copy mustache files:
cp -rv $dir/output/static/mustache/* $dir/output/data

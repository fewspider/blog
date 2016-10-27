#!/bin/bash

sourceDir=images/source
compressDir=images/compress
rm -rf $compressDir
for file in $(find $sourceDir/* -maxdepth 1 -type d)
  do
    dir=$(echo $file | awk -F"/" '{print $NF}' -)
    mkdir -p $compressDir/$dir
    jpegoptim $file/* --max=40 -s --dest $compressDir/$dir
  done

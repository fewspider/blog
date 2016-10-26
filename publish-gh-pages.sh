#!/bin/bash

function exe_cmd() {
    echo $1
    eval $1
}

branch='production'

exe_cmd "JEKYLL_ENV=production jekyll build"
if [ ! -d '_site' ];then
    echo "not content to be published"
    exit
fi

exe_cmd "git checkout $branch"
error_code=$?
if [ $error_code != 0 ];then
    echo 'Switch branch fail.'
    exit
else
    ls | grep -v _site CNAME|xargs rm -rf
    exe_cmd "cp -r _site/* ."
    exe_cmd "rm -rf _site/"
    exe_cmd "touch .nojekyll"
    exe_cmd "git add ."
    exe_cmd "git commit -m 'update'"
    exe_cmd "git push origin production"
fi

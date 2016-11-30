#!/bin/bash

set -ex

cd `dirname $0`

hugo

cd public/

git add .
git commit -m "Build site"
git push origin master

cd ..

git add .
git commit -m "Update blog source"
git push origin master

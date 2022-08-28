#!/bin/bash

#
# Creating hangullo git repo
#
git init
git add .
git commit -m "Initial commit"
# git remote add origin git@github.com:thinknimble/hangullo.git
gh repo create thinknimble/hangullo --private -y
git push origin main
printf "\033[0;32mRepo https://github.com/thinknimble/hangullo/\033[0m \n"

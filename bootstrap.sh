#!/bin/bash
cd $(dirname $0)

if [ ! -d .vim/bundle/vundle ]
then
	git clone https://github.com/gmarik/vundle.git .vim/bundle/vundle
fi

git pull
function doIt() {
	rsync --exclude ".git/" --exclude ".DS_Store" --exclude '*.example' --exclude "bootstrap.sh" --exclude "README.md" -av . ~
}
if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt
	fi
fi
unset doIt
source ~/.bash_profile

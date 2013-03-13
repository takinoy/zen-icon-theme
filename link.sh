#!/bin/sh
# link themes into theme directory

# options
opt=$1

# package name
pkgname=$(basename $(pwd))
name=${pkgname%-*}-dev
# first letter in uppercase
name=$(echo ${name:0:1}|tr a-z A-Z)${name:1}

# directory
link_dir="$HOME/.icons"
cd cache
path="scalable 16x16 22x22 32x32 index.theme"
echo $name $link_dir $path
#set $path
#echo $1
#exit 0

links() {
mkdir -v $link_dir/$name
set $path
for path
do
	if [ -e "$link_dir/$name/$path" ]
	then
		if [ -h !"$link_dir/$name/$path" ]
		then
		echo "$link_dir/$name/$path is not a link"
		fi
	else
	ln -s -r -v $path $link_dir/$name
	fi
done
}

# remove links from theme directory
remove_links() {
cd $link_dir
path=$(ls -1 | grep "^$name-.*dev")
rm -v $path
}

case $opt in
-r) remove_links;;
*) links;;
esac

#!/bin/sh
# chsh -s /bin/sh
# build package

# package name
pkgname=$(basename $(pwd))
name=${pkgname%-*}-dev

# build files
SUBDIRS=(16x16 22x22 32x32 scalable)

rm -r -f cache/$name
mkdir cache/$name
# copy sources
git archive HEAD | tar -x -C cache/$name

MAIN_DIR=$(pwd)
RECOLOR_DIR=recolor
IMAGE_DIR_OUT=$MAIN_DIR/cache/$name
cd $RECOLOR_DIR
git archive HEAD | tar -x -C $IMAGE_DIR_OUT/$RECOLOR_DIR

cd $IMAGE_DIR_OUT/$RECOLOR_DIR
# make included exec.
make
# recolor source files
./recolor.sh -c Br -H -O -p $MAIN_DIR/data/folders.dat $IMAGE_DIR_OUT

# reload icons
#./recolor.sh -p folders_paths $MAIN_DIR $IMAGE_DIR_OUT
#./recolor.sh -c Br -H -O -p folders_paths $MAIN_DIR $IMAGE_DIR_OUT

cd $IMAGE_DIR_OUT
patch -p1 < "../tango-icon-theme/rsvg.patch"
autoreconf -fi
#./configure --prefix=/home/cedric/.icons --datarootdir=/home/cedric/.icons --enable-png-creation
./configure --prefix=/usr
make

sudo make install

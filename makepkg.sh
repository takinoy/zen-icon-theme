#!/bin/sh

# use -f to force update
source cache/PKGBUILD
git archive --format=tar.gz --prefix=$pkgname-$pkgver/ HEAD > cache/$pkgname-$pkgver.tar.gz

cd cache
makepkg $1 --source --skipchecksums
makepkg $1 --skipchecksums
makepkg --install
yaourt -U $pkgname-$pkgver-*tar.xz

#~ rm -r cache/$pkgname
#~ mkdir cache/$pkgname
#~ git archive HEAD | tar -x -C cache/$pkgname
#~ cd cache/$pkgname
#~ ./autogen.sh

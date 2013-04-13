#!/bin/sh

# use -f to force update
source cache/PKGBUILD
git archive --prefix=$pkgname-$pkgver/ -o cache/$pkgname-$pkgver.tar.gz HEAD

cd cache
rm -r src
makepkg $1 --source --skipchecksums
makepkg $1 --skipchecksums --install

#~ rm -r cache/$pkgname
#~ mkdir cache/$pkgname
#~ git archive HEAD | tar -x -C cache/$pkgname
#~ cd cache/$pkgname
#~ ./autogen.sh

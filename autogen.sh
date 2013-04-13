# add missing standard files to package and configure it
aclocal
automake --add-missing
autoconf
./configure $1

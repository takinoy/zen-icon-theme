#!/bin/sh

cd ${1}
fixed_dirs=`find *x* -mindepth 1 -type d | sort -n`;
scalable_dirs=`find scalable -mindepth 1 -type d | sort`;
dirs="`echo $fixed_dirs $scalable_dirs | sed 's/ /,/g'`";
sed -i "s|\@THEME_DIRS\@|$dirs|g" index.theme;
for dir in `echo $dirs | sed -e "s/,/ /g"`; do
    sizefull="`dirname $dir`";
    if test "$sizefull" = "scalable"; then
        size="48";
    else
        size="`echo $sizefull | sed -e 's/x.*$//g'`";
    fi;
    context="`basename $dir`";
    echo "[$dir]" >> index.theme;
    if test "$context" = "actions"; then
        echo "Context=Actions" >> index.theme;
    fi;
    if test "$context" = "animations"; then
        echo "Context=Animations" >> index.theme;
    fi;
    if test "$context" = "apps"; then
        echo "Context=Applications" >> index.theme;
    fi;
    if test "$context" = "categories"; then
        echo "Context=Categories" >> index.theme;
    fi;
    if test "$context" = "devices"; then
        echo "Context=Devices" >> index.theme;
    fi;
    if test "$context" = "emblems"; then
        echo "Context=Emblems" >> index.theme;
    fi;
    if test "$context" = "emotes"; then
        echo "Context=Emotes" >> index.theme;
    fi;
    if test "$context" = "intl"; then
        echo "Context=International" >> index.theme;
    fi;
    if test "$context" = "mimetypes"; then
        echo "Context=MimeTypes" >> index.theme;
    fi;
    if test "$context" = "places"; then
        echo "Context=Places" >> index.theme;
    fi;
    if test "$context" = "status"; then
        echo "Context=Status" >> index.theme;
    fi;
    echo "Size=$size" >> index.theme;
    if test "$sizefull" = "scalable"; then
        echo "MinSize=32" >> index.theme;
        echo "MaxSize=512" >> index.theme;
        echo "Type=Scalable" >> index.theme;
    elif test "$size" = "256"; then
        echo "MinSize=56" >> index.theme;
        echo "MaxSize=512" >> index.theme;
        echo "Type=Scalable" >> index.theme;
    else
        echo "Type=Fixed" >> index.theme;
    fi;
    echo "" >> index.theme;
done

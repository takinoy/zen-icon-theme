# Process this file with autoconf to produce a configure script.
AC_PREREQ(2.53)

AC_INIT([zen-icon-theme], [0.1.0])
AC_CONFIG_SRCDIR(index.theme.in)

AM_INIT_AUTOMAKE([1.9 tar-ustar -Wno-portability ])

AC_PROG_INTLTOOL([0.33])
PKG_PROG_PKG_CONFIG([0.19])

GETTEXT_PACKAGE="${PACKAGE}"
AC_SUBST(GETTEXT_PACKAGE)

ALL_LINGUAS=""
AM_GLIB_GNU_GETTEXT

# AM_GLIB_GNU_GETTEXT above subst. $DATADIRNAME
# this is the directory where the *.{mo,gmo} files are installed
localedir='${prefix}/${DATADIRNAME}/locale'
AC_SUBST(localedir)

# Workaround to make aclocal get the right flags
AC_SUBST(ACLOCAL_AMFLAGS, "\${ACLOCAL_FLAGS}")

# Define the toplevel path here
AC_SUBST(themedir, "\${datadir}/icons/Zen")

UTILS_REQUIRED=0.8.90

AC_MSG_CHECKING([icon-naming-utils >= $UTILS_REQUIRED])
PKG_CHECK_EXISTS(icon-naming-utils >= $UTILS_REQUIRED,
                 have_utils=yes, have_utils=no)
if test "x$have_utils" = "xyes"; then
   UTILS_PATH="`$PKG_CONFIG --variable=program_path icon-naming-utils`"
   ICONMAP="$UTILS_PATH/icon-name-mapping"
   AC_SUBST(ICONMAP)
   AC_MSG_RESULT([yes])
else
   AC_MSG_RESULT([no])
   AC_MSG_ERROR([icon-naming-utils >= $UTILS_REQUIRED is required to build
                 and install zen-icon-theme])
fi

# recolor icons
AC_ARG_ENABLE(icon-recolor,
   AC_HELP_STRING([--enable-recolor-folders],
                   [enable recoloring folders [default=disable]]),
    enable_recolor=$enableval,
    enable_recolor=yes)
AM_CONDITIONAL(ENABLE_RECOLOR_FOLDERS, test x$enable_recolor = xyes)

if test "x$enable_recolor" = "xyes"; then
   PKG_CHECK_EXISTS([recolor],
                    [enable_recolor=yes],
            PKG_CHECK_EXISTS([GraphicsMagick >= 1.1],
                     [enable_framing=yes], [enable_framing=no]))
   if test "x$enable_recolor" = "xyes"; then
      AC_PATH_PROG(RECOLOR, recolor)
      if test -z "$RECOLOR"; then
         AC_MSG_ERROR([recolor is required to build zen-icon-theme])
      fi
      AC_SUBST(RECOLOR)
   else
      AC_MSG_ERROR([recolor.sh is required to build zen-icon-theme])
   fi
fi

# Check for convert from ImageMagick to add the 1x1 frame to 22x22 icons
AC_ARG_ENABLE(icon-framing,
   AC_HELP_STRING([--disable-icon-framing],
                   [disable creation of 24x24 icons [default=enabled]]),
    enable_framing=$enableval,
    enable_framing=yes)
AM_CONDITIONAL(ENABLE_ICON_FRAMING, test x$enable_framing = xyes)

FRAMING_SIZE=''
if test "x$enable_framing" = "xyes"; then
   PKG_CHECK_EXISTS([ImageMagick >= 5.5.7],
                    [enable_framing=yes],
		    PKG_CHECK_EXISTS([GraphicsMagick >= 1.1],
				     [enable_framing=yes], [enable_framing=no]))
   if test "x$enable_framing" = "xyes"; then
      AC_PATH_PROG(CONVERT, convert)
      if test -z "$CONVERT"; then
      	 AC_MSG_ERROR([ImageMagick is required to build zen-icon-theme])
      fi

      # Add the command line options we need here
      CONVERT="$CONVERT -bordercolor Transparent -border 1x1"
      AC_SUBST(CONVERT)
      FRAMING_SIZE="24x24"
   else
      AC_MSG_ERROR([ImageMagick is required to build zen-icon-theme])
   fi
fi

# Check for rsvg for creating large scale bitmaps from svg
AC_ARG_ENABLE(png-creation,
   AC_HELP_STRING([--enable-png-creation],
                   [enable creating png images from svg [default=disabled]]),
    enable_large_bitmaps=$enableval,
    enable_large_bitmaps=no)

SVGCONVERT=""
AC_MSG_CHECKING([SVG to PNG conversion method])
PKG_CHECK_EXISTS([librsvg-2.0 >= 2.12.3])
svgconvert_prog="rsvg-convert"
AC_MSG_RESULT([$svgconvert_prog])
AC_PATH_PROG(SVGCONVERT, $svgconvert_prog)
if test -z "$SVGCONVERT"; then
  AC_MSG_ERROR([You need librsvg >= 2.12.3 or ksvgtopng installed build the package])
fi

LARGE_SIZES='48x48 64x64 128x128'
if test "x$enable_large_bitmaps" = "xyes"; then
    LARGE_SIZES="48x48 64x64 128x128"
fi

AC_SUBST(SVGCONVERT)
AM_CONDITIONAL(ENABLE_LARGE_BITMAPS, test x$enable_large_bitmaps = xyes)

# Icon sizes we want to install
AC_SUBST(FRAMING_SIZE)
AC_SUBST(LARGE_SIZES)

AC_CONFIG_FILES([
data/folders.dat
Makefile
src/Makefile
dark/Makefile
dark-panel/Makefile
po/Makefile.in
])	

AC_OUTPUT

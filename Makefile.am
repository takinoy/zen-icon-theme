DISTCHECK_CONFIGURE_FLAGS = --disable-icon-framing --enable-png-creation \
--enable-icon-recolor

SUBDIRS = stock po

THEME_IN_FILES = index.theme.in

@INTLTOOL_THEME_RULE@

theme_DATA = index.theme

EXTRA_DIST=				\
	$(THEME_IN_FILES)		\
	svg2png.sh.in			\
	intltool-update.in 		\
	intltool-merge.in 		\
	intltool-extract.in

# recolor source files
install: install-recolor install-recursive

install-recolor:
if ENABLE_RECOLOR_FOLDERS
	($(RECOLOR) -M -H -O -p $(abs_top_builddir)/data/folders.dat $(abs_top_builddir))
endif

# we don't want to install mo files, all translations are already stored
# in theme files
install-data-local:
	for size in 16x16 22x22 32x32; do \
		echo -e "Copying icons files for $$size..."; \
		for dir in `find $$size -type d`; do \
			$(mkdir_p) $(DESTDIR)$(themedir)/$$dir; \
		done; \
		for icon in `find $$size -name "*.png" -type f`; do \
			$(install_sh_DATA) $$icon $(DESTDIR)$(themedir)/$$icon; \
		done; \
	done; \
	echo -e "Copying icons files for scalable..."; \
	for dir in `find scalable -type d`; do \
		$(mkdir_p) $(DESTDIR)$(themedir)/$$dir; \
	done; \
	for icon in `find scalable -name "*.svg" -type f`; do \
		$(install_sh_DATA) $$icon $(DESTDIR)$(themedir)/$$icon; \
	done; 
if ENABLE_ICON_FRAMING
	echo -e "Converting icons files from 22x22 to $(FRAMING_SIZE)..."; \
	cd $(DESTDIR)$(themedir); \
	cd 22x22 && \
	for dir in `find * -type d`; do \
		$(mkdir_p) $(DESTDIR)$(themedir)/$(FRAMING_SIZE)/$$dir; \
	done; \
	for icon in `find * -name "*.png" -type f`; do \
		$(CONVERT) $$icon $(DESTDIR)$(themedir)/$(FRAMING_SIZE)/$$icon; \
	done; \
	cd ..; 
endif
if ENABLE_LARGE_BITMAPS
	for size in $(LARGE_SIZES); do \
		echo -e "Converting icons files from scalable to $$size..."; \
		cd scalable && \
		for dir in `find * -type d`; do \
			$(mkdir_p) $(DESTDIR)$(themedir)/$$size/$$dir; \
		done; \
		for icon in `find * -name "*.svg" -type f`; do \
			pngdir=`dirname $(DESTDIR)$(themedir)/$$size/$$icon`; \
			i=$${size%x*}; \
			$(abs_top_builddir)/svg2png.sh $$i $$pngdir $$icon; \
		done; \
		cd ..; \
	done;
endif
	if [ $(ICONMAP) != "false" ]; then \
	cd $(DESTDIR)$(themedir); \
	for size in 16x16 22x22 $(FRAMING_SIZE) 32x32 scalable $(LARGE_SIZES); do \
		cd $$size || continue; \
		echo -e "Set up icon mapping for $$size..."; \
		for dir in `find . -type d`; do \
			context="`echo $$dir | cut -c 3-`"; \
			if [ $$context ]; then \
				$(ICONMAP) -c $$context; \
			fi; \
		done; \
		cd ..; \
	done; \
	fi; \
	$(MAKE) -C $(abs_top_builddir)/po uninstall; \
	if [ -h $(DESTDIR)$(themedir) ]; then \
		rm -f $(DESTDIR)$(themedir); \
	fi; \
	if [ -d $(DESTDIR)$(themedir) ]; then \
		touch $(DESTDIR)$(themedir); \
	fi

CLEANFILES = 				\
	index.theme

DISTCLEANFILES = 			\
	svg2png.sh			\
	intltool-extract		\
	intltool-merge			\
	intltool-update

MAINTAINERCLEANFILES =			\
	Makefile.in			\
	aclocal.m4			\
	configure			\
	install-sh			\
	intltool-extract.in		\
	intltool-merge.in		\
	intltool-update.in		\
	missing				\
	mkinstalldirs


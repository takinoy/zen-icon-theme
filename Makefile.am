DISTCHECK_CONFIGURE_FLAGS = --disable-icon-framing --enable-png-creation \
--enable-icon-recolor

MAINDIR = Zen
VARIANTS = dark dark-panel
SUBDIRS = $(VARIANTS) stock po

THEME_IN_FILES = index.theme.in

@INTLTOOL_THEME_RULE@

theme_DATA = index.theme

EXTRA_DIST=				\
	$(THEME_IN_FILES)		\
	intltool-update.in 		\
	intltool-merge.in 		\
	intltool-extract.in

install-data-am: install-data-local install-themeDATA
	($(abs_top_builddir)/index.theme.sh $(DESTDIR)$(themedir))

install-recolor:
if ENABLE_RECOLOR_FOLDERS
	($(RECOLOR) -M -H -O -p $(abs_top_builddir)/data/folders.dat $(abs_top_builddir))
endif

# we don't want to install mo files, all translations are already stored
# in theme files
install-data-local:
	for size in 16x16 22x22 32x32 $(LARGE_SIZES); do \
		echo -e "Copying icons files for $$size..."; \
		for dir in `find $$size -type d`; do \
			$(mkdir_p) $(DESTDIR)$(themedir)/$$dir; \
		done; \
		for icon in `find $$size -name "*.png"`; do \
			$(install_sh_DATA) $$icon $(DESTDIR)$(themedir)/$$icon; \
		done; \
	done; \
	echo -e "Copying icons files for scalable..."; \
	for dir in `find scalable -type d`; do \
		$(mkdir_p) $(DESTDIR)$(themedir)/$$dir; \
	done; \
	for icon in `find scalable -name "*.svg"`; do \
		$(install_sh_DATA) $$icon $(DESTDIR)$(themedir)/$$icon; \
	done;
if ENABLE_RECOLOR_FOLDERS
	($(RECOLOR) -M -H -O -p $(abs_top_builddir)/data/folders.dat $(DESTDIR)$(themedir))
endif
if ENABLE_ICON_FRAMING
	echo -e "Converting icons files from 22x22 to $(FRAMING_SIZE)..."; \
	cd $(DESTDIR)$(themedir); \
	cd 22x22 && \
	for dir in `find * -type d`; do \
		$(mkdir_p) $(DESTDIR)$(themedir)/$(FRAMING_SIZE)/$$dir; \
	done; \
	for icon in `find * -name "*.png"`; do \
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
		for icon in `find * -name "*.svg"`; do \
			pngpath="$(DESTDIR)$(themedir)/$$size/$${icon%.*}.png"; \
			i=$${size%x*}; \
			$(SVGCONVERT) $$icon -w $$i -h $$i -o $$pngpath; \
		done; \
		cd ..; \
	done;
endif
	cd $(DESTDIR)$(themedir); \
	if [ $(ICONMAP) != "false" ]; then \
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
	for var in $(VARIANTS); do \
		icons_paths=`cat $(abs_top_builddir)/$$var/$$var.lst`; \
		for size in 16x16 22x22 $(FRAMING_SIZE) 32x32 $(LARGE_SIZES); do \
			cd $$size || continue; \
			echo -e "link $(MAINDIR) to $(MAINDIR)-$$var for $$size..."; \
			for icon_path in $$icons_paths; do \
				if [[ -f $$icon_path.png ]] && \
				[[ ! -f ../../$(MAINDIR)-$$var/$$size/$$icon_path.png ]];then \
				$(mkdir_p) ../../$(MAINDIR)-$$var/$$size/$${icon_path%/*}; \
				ln -sr $$icon_path.png \
				../../$(MAINDIR)-$$var/$$size/$$icon_path.png; \
				links=`find -L * -samefile $$icon_path.png -xtype l`; \
					if [[ $$links != '' ]]; then \
					cp -P $$links \
					../../$(MAINDIR)-$$var/$$size/$${icon_path%/*}; \
					fi; \
				fi; \
			done; \
			cd ..; \
		done; \
		cd scalable || continue; \
		echo -e "link $(MAINDIR) to $(MAINDIR)-$$var for scalable..."; \
		for icon_path in $$icons_paths; do \
			if [[ -f $$icon_path.svg ]] && \
			[[ ! -f ../../$(MAINDIR)-$$var/scalable/$$icon_path.svg ]];then \
			$(mkdir_p) ../../$(MAINDIR)-$$var/scalable/$${icon_path%/*}; \
			ln -sr $$icon_path.svg \
			../../$(MAINDIR)-$$var/scalable/$$icon_path.svg; \
			links=`find -L * -samefile $$icon_path.svg -xtype l`; \
				if [[ $$links != '' ]]; then \
				cp -P $$links \
				../../$(MAINDIR)-$$var/scalable/$${icon_path%/*}; \
				fi; \
			fi; \
		done; \
		cd ..; \
	done; \
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


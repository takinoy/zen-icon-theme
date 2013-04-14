themedir = ${datadir}/icons/Tango-colors-dark-panel

THEME_IN_FILES = index.theme.in

@INTLTOOL_THEME_RULE@

theme_DATA = index.theme

EXTRA_DIST=				\
	$(THEME_IN_FILES)

install-data-am: install-data-local install-themeDATA
	($(abs_top_builddir)/index.theme.sh $(DESTDIR)$(themedir))

install-data-local:
	echo -e "Make dark-panel icons files..."; \
	$(RECOLOR) ../stock -negate -modulate 92 -p dark-panel.dat "."; \
	for size in 16x16 22x22; do \
		echo -e "Converting svg icons files to png for size $$size..."; \
		cd scalable && \
		for dir in `find * -type d`; do \
			$(mkdir_p) $(DESTDIR)$(themedir)/$$size/$$dir; \
		done; \
		for icon in `find * -name "*.svg"`; do \
			pngdir=`dirname $(DESTDIR)$(themedir)/$$size/$$icon`; \
			i=$${size%x*}; \
			$(abs_top_builddir)/svg2png.sh $$i $$pngdir $$icon; \
		done; \
		cd ..; \
	done; \
	for size in 16x16 22x22; do \
		echo -e "Converting svg icons files to png for size $$size (Faenza)..."; \
		cd $$size && \
		for dir in `find * -type d`; do \
			$(mkdir_p) $(DESTDIR)$(themedir)/$$size/$$dir; \
		done; \
		for icon in `find * -name "*.svg"`; do \
			pngdir=`dirname $(DESTDIR)$(themedir)/$$size/$$icon`; \
			i=$${size%x*}; \
			$(abs_top_builddir)/svg2png.sh $$i $$pngdir $$icon; \
		done; \
		cd ..; \
	done; \
	for size_svg in scalable; do \
		cd $$size_svg && \
			echo -e "Copying icons files for scalable..."; \
			for dir in `find * -type d`; do \
				$(mkdir_p) $(DESTDIR)$(themedir)/scalable/$$dir; \
			done; \
			for icon in `find * -name "*.svg"`; do \
				$(install_sh_DATA) \
				$$icon $(DESTDIR)$(themedir)/scalable/$$icon; \
			done; \
		cd ..; \
	done;
if ENABLE_ICON_FRAMING
	echo -e "Converting dark-panel icons files from 22x22 to $(FRAMING_SIZE)..."; \
	cd $(DESTDIR)$(themedir); \
	cd 22x22 && \
	for dir in `find * -type d`; do \
		$(mkdir_p) ../$(FRAMING_SIZE)/$$dir; \
	done; \
	for icon in `find * -name "*.png"`; do \
		$(CONVERT) $$icon ../$(FRAMING_SIZE)/$$icon; \
	done; \
	cd ..;
endif
	if [ $(ICONMAP) != "false" ]; then \
	cd $(DESTDIR)$(themedir); \
	for size in 16x16 22x22 $(FRAMING_SIZE); do \
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
	fi;

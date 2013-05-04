themedir = ${datadir}/icons/Zen-dark-panel

THEME_IN_FILES = index.theme.in

@INTLTOOL_THEME_RULE@

theme_DATA = index.theme

EXTRA_DIST=				\
	$(THEME_IN_FILES)

install-data-am: install-data-local install-themeDATA
	($(abs_top_builddir)/index.theme.sh $(DESTDIR)$(themedir))

install-data-local:
	echo -e "Make dark-panel icons files..."; \
	$(RECOLOR) ../src -negate -modulate 92 -p dark-panel.dat "."; \
	for size in 16x16 22x22; do \
		echo -e "Converting $$size svg icons to $$size png..."; \
		cd $$size && \
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
		cd status && while read icons; do \
		set $$icons; isrc=$$1; shift; \
		for icon; do \
		if [[ $$size == 'scalable' ]]; then \
		ln -sr $$isrc.svg $$icon.svg; \
		else ln -sr $$isrc.png $$icon.png; fi \
		done; \
		done < $(abs_top_builddir)/src/status.lst; \
		cd ..; \
		cd ..; \
	done; \
	fi;

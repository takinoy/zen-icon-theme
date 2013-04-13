
install-data-local:
	for size in 16x16 22x22 32x32; do \
		echo -e "Converting svg icons files to png for size $$size..."; \
		cd 48x48 && \
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
	for size in 32x32; do \
		echo -e "Converting svg icons files to png for size $$size (Faenza)..."; \
		cd 96x96 && \
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
	for size_svg in 48x48 96x96; do \
		cd $$size_svg && \
			echo -e "Copying icons files for scalable..."; \
			for dir in `find $$size_svg -type d`; do \
				$(mkdir_p) $(DESTDIR)$(themedir)/scalable/$$dir; \
			done; \
			for icon in `find $$size_svg -name "*.svg"`; do \
				$(install_sh_DATA) $$icon $(DESTDIR)$(themedir)/scalable/$$icon; \
			done; \
		cd ..; \
	done;

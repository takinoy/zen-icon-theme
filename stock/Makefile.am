
install-data-local:
	for size in 16x16 22x22 32x32; do \
		echo -e "Converting svg icons files to png for size $$size..."; \
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
	done; \
	for size in 16x16 22x22 32x32; do \
		echo -e "Converting svg icons files to png for size $$size (Faenza)..."; \
		cd $$size && \
		for dir in `find * -type d`; do \
			$(mkdir_p) $(DESTDIR)$(themedir)/$$size/$$dir; \
		done; \
		for icon in `find * -name "*.svg"`; do \
			pngpath="$(DESTDIR)$(themedir)/$$size/$${icon%.*}.png"; \
			i=$${size%x*}; \
			$(SVGCONVERT) $$icon -o $$pngpath; \
		done; \
		cd ..; \
	done; \
	for size_svg in 96x96; do \
		cd $$size_svg && \
		echo -e "Converting svg icons files to png for size $$size..."; \
		for dir in `find * -type d`; do \
			$(mkdir_p) $(DESTDIR)$(themedir)/32x32/$$dir; \
		done; \
		for icon in `find * -name "*.svg"`; do \
			pngpath="$(DESTDIR)$(themedir)/32x32/$${icon%.*}.png"; \
			$(SVGCONVERT) $$icon -w 32 -h 32 -o $$pngpath; \
		done; \
		cd ..; \
	done; \
	for size_svg in scalable 48x48 96x96; do \
		echo -e "Copying $$size_svg icons files for scalable..."; \
		cd $$size_svg && \
			for dir in `find * -type d`; do \
				$(mkdir_p) $(DESTDIR)$(themedir)/scalable/$$dir; \
			done; \
			for icon in `find * -name "*.svg"`; do \
				$(install_sh_DATA) $$icon $(DESTDIR)$(themedir)/scalable/$$icon; \
			done; \
		cd ..; \
	done;

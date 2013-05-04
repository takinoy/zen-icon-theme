
install-data-local:
	for size in 16x16 22x22 32x32; do \
		echo -e "Converting $$size svg icons to $$size png..."; \
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
	for size in 16x16 22x22 32x32; do \
		echo -e "Converting scalable svg icons to $$size png..."; \
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
	for size_svg in Faenza_48x48; do \
		echo -e "Converting $$size_svg svg icons to 32x32 png..."; \
		cd $$size_svg && \
		for dir in `find * -type d`; do \
			$(mkdir_p) $(DESTDIR)$(themedir)/32x32/$$dir; \
		done; \
		for icon in `find * -name "*.svg"`; do \
			pngpath="$(DESTDIR)$(themedir)/32x32/$${icon%.*}.png"; \
			$(SVGCONVERT) $$icon -w 32 -h 32 -o $$pngpath; \
		done; \
		cd ..; \
	done; \
	for size_svg in scalable 48x48 Faenza_48x48; do \
		echo -e "Copying $$size_svg icons to scalable..."; \
		cd $$size_svg && \
			for dir in `find * -type d`; do \
				$(mkdir_p) $(DESTDIR)$(themedir)/scalable/$$dir; \
			done; \
			for icon in `find * -name "*.svg"`; do \
				$(install_sh_DATA) $$icon $(DESTDIR)$(themedir)/scalable/$$icon; \
			done; \
		cd ..; \
	done;

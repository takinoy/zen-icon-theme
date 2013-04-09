
size = 32x32
context = apps

iconsdir = $(themedir)/$(size)/$(context)

icons_DATA = $(shell find $(srcdir) -name "*.png" -type f -printf "%f\n")

EXTRA_DIST =						\
	$(icons_DATA)

install-data-local: install-iconsDATA
	(cd $(DESTDIR)$(themedir)/$(size) && $(ICONMAP) -c $(context))

V=20120618

PREFIX = /usr/local

BINPROGS = \
	arch-chroot \
	genfstab \
	pacstrap

all: $(BINPROGS)

%: %.in Makefile common
	@printf '  GEN\t%s\n' "$@"
	@$(RM) "$@"
	@m4 -P $@.in >$@
	@chmod a-w "$@"
	@chmod +x "$@"

clean:
	$(RM) $(BINPROGS)

install:
	install -dm755 $(DESTDIR)$(PREFIX)/bin
	install -m755 ${BINPROGS} $(DESTDIR)$(PREFIX)/bin

uninstall:
	for f in ${BINPROGS}; do $(RM) $(DESTDIR)$(PREFIX)/bin/$$f; done

dist:
	git archive --format=tar --prefix=arch-install-scripts-$(V)/ $(V) | gzip -9 > arch-install-scripts-$(V).tar.gz
	gpg --detach-sign --use-agent arch-install-scripts-$(V).tar.gz

.PHONY: all clean install uninstall dist

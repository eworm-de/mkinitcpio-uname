# Makefile for mkinitcpio-uname

VERSION=0.2.0

all:
	@echo "Just run make install..."

.PHONY: install
install:
	install -D -m0644 install/uname $(DESTDIR)/usr/lib/initcpio/install/uname
	install -D -m0755 hook/uname $(DESTDIR)/usr/lib/initcpio/hooks/uname
	install -D -m0644 systemd/uname.service $(DESTDIR)/usr/lib/systemd/system/uname.service
	install -D -m0755 systemd/uname $(DESTDIR)/usr/lib/systemd/scripts/uname

release:
	git archive --format=tar.xz --prefix=mkinitcpio-uname-$(VERSION)/ $(VERSION) > mkinitcpio-uname-$(VERSION).tar.xz
	gpg -ab mkinitcpio-uname-$(VERSION).tar.xz
	git notes --ref=refs/notes/signatures/tar add -C $$(git archive --format=tar --prefix=mkinitcpio-uname-$(VERSION)/ $(VERSION) | gpg --armor --detach-sign | git hash-object -w --stdin) $(VERSION)

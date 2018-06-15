# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools

DESCRIPTION="A Gtk+ module and Mate/Xfce/LXDE panel applets for a global menubar"
HOMEPAGE="https://git.javispedro.com/cgit/topmenu-gtk.git/about/"
SRC_URI="https://git.javispedro.com/cgit/topmenu-gtk.git/snapshot/topmenu-gtk-release_0.3.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="lxde mate xfce"

DEPEND="x11-libs/gtk+:3
		x11-libs/libwnck:1
		mate-base/mate-panel"
RDEPEND="${DEPEND}"

S="${WORKDIR}/topmenu-gtk-release_${PV}"

src_configure() {
	eautoreconf
	econf --prefix=/usr --with-gtk=2 --with-wnck=wnck1 \
			--disable-static \
			$(use_enable lxde lxpanel-plugin) \ 
			$(use_enable xfce xfce-applet) \ 
			$(use_enable mate mate-applet) \
			--libexecdir=/usr/lib/topmenu
}

src_install() {
	emake DESTDIR="${ED}" install
	prune_libtool_files --all
}


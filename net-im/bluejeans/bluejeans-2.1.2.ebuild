# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker

DESCRIPTION="Bluejeans desktop app for viewo calls"
HOMEPAGE="https://www.bluejeans.com"
SRC_URI="https://swdl.bluejeans.com/desktop-app/linux/${PV}/BlueJeans.deb"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}"

src_unpack() {
	unpack_deb ${A}
}

src_install(){
	cp -R "${S}/"* "${D}/" || die "Install failed!"
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}


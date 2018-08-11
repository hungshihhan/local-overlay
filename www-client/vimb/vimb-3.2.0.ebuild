# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="a fast, lightweight, vim-like browser based on webkit"
HOMEPAGE="http://fanglingsu.github.io/vimb/"
SRC_URI="https://github.com/fanglingsu/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	net-libs/webkit-gtk:4"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_compile() {
	emake PREFIX=/usr
}

src_install() {
	emake PREFIX=/usr DESTDIR="${D}" install
}

# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit pax-utils eutils xdg-utils

if [ "${ARCH}" = "amd64" ] ; then
		LNXARCH="linux-x86_64"
else
		LNXARCH="linux-i686"
fi

DESCRIPTION="Zotero [zoh-TAIR-oh] is a free, easy-to-use tool to help you collect, organize, cite, and share your research sources."
HOMEPAGE="https://www.zotero.org/"
SRC_URI="https://download.zotero.org/client/release/${PV}/Zotero-${PV}_${LNXARCH}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="mirror strip"
IUSE="pax_kernel"

DEPEND="${RDEPEND}
	pax_kernel? (
		sys-apps/attr
		sys-apps/paxctl
	)"

RDEPEND=""

S="${WORKDIR}/Zotero_${LNXARCH}"

ZOTERO_INSTALL_DIR="/opt/${PN}"

src_prepare(){ 
#	echo "${P}" > ${S}/VERSION.zotero
	epatch "${FILESDIR}/desktop.patch"
}


src_install() {

	# install zotero files to /opt/Zotero
	dodir ${ZOTERO_INSTALL_DIR}
	cp -a ${S}/. ${D}${ZOTERO_INSTALL_DIR} || die "Installing files failed"

	# install zotero-start.sh in /opt/Zotero
	touch $D${ZOTERO_INSTALL_DIR}/zotero-start.sh

	# give it some instructions to start zotero
	echo "#!/bin/sh" >> $D${ZOTERO_INSTALL_DIR}/zotero-start.sh
	echo "exec "${ZOTERO_INSTALL_DIR}/zotero"" >>  $D${ZOTERO_INSTALL_DIR}/zotero-start.sh

	# make zotero-start.sh executable
	fperms +x ${ZOTERO_INSTALL_DIR}/zotero-start.sh
	fperms +x ${ZOTERO_INSTALL_DIR}/zotero

	# sym link /opt/Zotero/zotero-start.sh to /opt/bin/zotero
	dosym ${ZOTERO_INSTALL_DIR}/zotero-start.sh /opt/bin/zotero

	domenu "${ZOTERO_INSTALL_DIR}/zotero.desktop"
	if use pax_kernel; then
		#create the headers, reset them to default, then paxmark -em them
		pax-mark C "$D${ZOTERO_INSTALL_DIR}/zotero-bin" || die
		pax-mark m "$D${ZOTERO_INSTALL_DIR}/zotero-bin" || die
		eqawarn "You have set USE=pax_kernel meaning that you intend to run"
		eqawarn "${PN} under a PaX enabled kernel.  To do so, we must modify"
		eqawarn "the ${PN} binary itself and this *may* lead to breakage!"
	fi
}

pkg_postinst() {
	# Update mimedb for the new .desktop file
	xdg_desktop_database_update
}

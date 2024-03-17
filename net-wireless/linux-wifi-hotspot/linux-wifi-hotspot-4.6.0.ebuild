# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop

DESCRIPTION="Feature-rich wifi hotspot creator for Linux which provides both GUI and command-line interface"
HOMEPAGE="https://github.com/lakinduakash/linux-wifi-hotspot"
SRC_URI="https://github.com/lakinduakash/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="BSD-2"
SLOT=0
KEYWORDS="amd64"

RDEPEND="
	media-gfx/qrencode
	net-firewall/iptables
	net-wireless/hostapd
	net-dns/dnsmasq
	sys-apps/iproute2
	"

src_install() {
	emake DESTDIR="${D}" install
	mv ${D}/usr/share/doc/create_ap ${D}/usr/share/doc/${P}
	sed -i "s/\'/\"/g" ${D}/usr/share/applications/wihotspot.desktop
}

TERMUX_PKG_HOMEPAGE="https://gitlab.com/accounts-sso/signond/"
TERMUX_PKG_DESCRIPTION="A D-Bus service which performs user authentication on behalf of its clients"
TERMUX_PKG_LICENSE="LGPL-2.1-only"
TERMUX_PKG_LICENSE_FILE="COPYING"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="8.61"
TERMUX_PKG_SRCURL="https://gitlab.com/accounts-sso/signond/-/archive/VERSION_${TERMUX_PKG_VERSION}/signond-VERSION_${TERMUX_PKG_VERSION}.tar.gz"
TERMUX_PKG_SHA256="3dd57c25e1bf1583b2cb857f96831e38e73d40264ff66ca43e63bb7233f76828"
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_UPDATE_VERSION_REGEXP="VERSION_\d+.\d+"
TERMUX_PKG_UPDATE_VERSION_SED_REGEXP="s/VERSION_//"
TERMUX_PKG_DEPENDS="libc++, qt6-qtbase"
TERMUX_PKG_BUILD_DEPENDS="qt6-qttools, ttf-dejavu"

termux_step_pre_configure() {
	export PKG_CONFIG_SYSROOT_DIR="$TERMUX__ROOTFS"
}

termux_step_configure() {
	termux_step_configure_qmake6
}

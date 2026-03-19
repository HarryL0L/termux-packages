TERMUX_PKG_HOMEPAGE=https://launchpad.net/compiz
TERMUX_PKG_DESCRIPTION="OpenGL window and compositing manager"
TERMUX_PKG_LICENSE="GPL-2.0-or-later, LGPL-2.1-or-later, MIT"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=0.9.14.2
TERMUX_PKG_SRCURL="https://launchpad.net/compiz/${TERMUX_PKG_VERSION%.*}/${TERMUX_PKG_VERSION}/+download/compiz-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256=cfa061e93b032275ff9e7041f582a8f6d5ae271cf8a89e6bc74e3d3635999d3c
TERMUX_PKG_DEPENDS="dbus-python, glu, libglibmm-2.4, libice, libnotify, libsm, libwnck, protobuf, pycairo, pygobject, python"
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_UPDATE_TAG_TYPE=newest-tag

termux_step_pre_configure() {
	# This doesn't seem to solve the issue.
	termux_setup_gir
	termux_setup_glib_cross_pkg_config_wrapper
}

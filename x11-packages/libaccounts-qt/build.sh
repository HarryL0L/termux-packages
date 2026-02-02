TERMUX_PKG_HOMEPAGE="https://gitlab.com/accounts-sso/libaccounts-qt"
TERMUX_PKG_DESCRIPTION="Qt-based client library for accessing the online accounts database"
TERMUX_PKG_LICENSE="LGPL-2.1-or-later"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="1.17"
TERMUX_PKG_SRCURL="https://gitlab.com/accounts-sso/libaccounts-qt/-/archive/VERSION_${TERMUX_PKG_VERSION}/libaccounts-qt-VERSION_${TERMUX_PKG_VERSION}.tar.gz"
TERMUX_PKG_SHA256="6ed3e976133962c1c88f6c66928ba0d0a17a570843577d31e783dc891659e5d8"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="glib, libc++, libaccounts-glib, qt6-qtbase"

termux_step_pre_configure() {
	TERMUX_PKG_BUILDDIR="$TERMUX_PKG_SRCDIR"
}

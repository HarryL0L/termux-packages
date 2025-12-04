TERMUX_PKG_HOMEPAGE="https://github.com/frankosterfeld/qtkeychain"
TERMUX_PKG_DESCRIPTION="Provides support for secure credentials storage"
TERMUX_PKG_LICENSE="BSD-3-Clause"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="0.15.0"
TERMUX_PKG_SRCURL="https://github.com/frankosterfeld/qtkeychain/archive/refs/tags/${TERMUX_PKG_VERSION}.tar.gz"
TERMUX_PKG_SHA256="f4254dc8f0933b06d90672d683eab08ef770acd8336e44dfa030ce041dc2ca22"
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="glib2, kf6-kwallet, libc++, qt6-qtbase"
TERMUX_PKG_BUILD_DEPENDS="clang, cmake, git, qt6-qtdeclarative, qt6-qttools"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
"

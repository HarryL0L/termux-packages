TERMUX_PKG_HOMEPAGE="https://gitlab.freedesktop.org/libinput/libinput"
TERMUX_PKG_DESCRIPTION="Input device management and event handling library"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="1.31.0"
TERMUX_PKG_SRCURL="git+https://gitlab.freedesktop.org/libinput/libinput.git"
TERMUX_PKG_GIT_BRANCH="main"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="libc++, libevdev, lua52, libudev-zero, mtdev"
TERMUX_PKG_BUILD_DEPENDS="check, gtk4, libudev-zero, libwayland, libwayland-protocols, libx11, python"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-Dtests=false
-Ddocumentation=false
-Ddebug-gui=false
-Dlibwacom=false
-Dmtdev=false
-Dinstall-tests=false
-Dlua-plugins=disabled
-Dautoload-plugins=false
"
#this doesn't work for testing only.

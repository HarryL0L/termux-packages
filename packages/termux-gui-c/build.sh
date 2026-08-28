TERMUX_PKG_HOMEPAGE="https://github.com/tareksander/termux-gui-c-bindings"
TERMUX_PKG_DESCRIPTION="A C library for the Termux:GUI plugin"
TERMUX_PKG_LICENSE="MPL-2.0"
TERMUX_PKG_MAINTAINER="@HarryL0L"
TERMUX_PKG_VERSION="0.1"
#TERMUX_PKG_REVISION=7
TERMUX_PKG_DEPENDS="abseil-cpp, libc++, libandroid-stub, libprotobuf"
TERMUX_PKG_SRCURL="https://github.com/HarryL0L/termux-gui-c-bindings/archive/refs/tags/${TERMUX_PKG_VERSION}.tar.gz"
TERMUX_PKG_SHA256=e0095c6dcc0b77dba11a6d033ae3815f98024cc4d6261e4a8b368c5b7653b9
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_UPDATE_TAG_TYPE="newest-tag"

termux_step_pre_configure() {
	termux_setup_protobuf
	export SHARED_BUILD=1
}

TERMUX_PKG_HOMEPAGE="https://invent.kde.org/pim/akonadi"
TERMUX_PKG_DESCRIPTION="Cross-desktop storage service for PIM data providing concurrent access"
TERMUX_PKG_LICENSE="LGPL-2.0-or-later"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="25.12.1"
TERMUX_PKG_SRCURL="https://download.kde.org/stable/release-service/${TERMUX_PKG_VERSION}/src/akonadi-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256="fa0ff9007e0fb1803911a2f1a5cdadf2bf3f714845a583872b787f7b52714ff0"
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_HOSTBUILD=true
TERMUX_PKG_DEPENDS="kaccounts-integration, kf6-kcolorscheme, kf6-kconfig, kf6-kconfigwidgets, kf6-kcoreaddons, kf6-kcrash, kf6-ki18n, kf6-kiconthemes, kf6-kitemmodels, kf6-kwidgetsaddons, kf6-kxmlgui, kirigami-addons, libc++, libaccounts-qt, liblzma, libxml2, qt6-qtbase"
TERMUX_PKG_BUILD_DEPENDS="extra-cmake-modules, kaccounts-integration, kf6-kconfigwidgets, kf6-kiconthemes, kf6-kitemmodels, kf6-kxmlgui, postgresql, qt6-qttools"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"

termux_step_host_build() {
	if [[ "$TERMUX_ON_DEVICE_BUILD" == "true" ]]; then
		return
	fi

termux_download_ubuntu_packages libkf6configwidgets-dev

	termux_setup_cmake
	termux_setup_ninja

	cmake -G Ninja \
		-S "${TERMUX_PKG_SRCDIR}" \
		-B "${TERMUX_PKG_HOSTBUILD_DIR}" \
		-DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_INSTALL_PREFIX=$TERMUX_PREFIX/opt/kf6/cross \
		-DCMAKE_PREFIX_PATH="$TERMUX_PREFIX/opt/qt6/cross/lib/cmake" \
		-DCMAKE_MODULE_PATH="$TERMUX_PREFIX/share/ECM/modules" \
		-DECM_DIR="$TERMUX_PREFIX/share/ECM/cmake" \
		-DTERMUX_PREFIX="$TERMUX_PREFIX" \
		-DCMAKE_INSTALL_LIBDIR=lib \
		-DBUILD_TESTING=OFF \
		-DBUILD_TOOLS=OFF \
		-DBUILD_DESIGNERPLUGIN=OFF \
		-DINSTALL_APPARMOR=OFF \
		-DKF6ConfigWidgets_DIR=/usr/lib/x86_64-linux-gnu/cmake/KF6ConfigWidgets

	ninja -j ${TERMUX_PKG_MAKE_PROCESSES} protocolgen


	# Copy protocolgen to cross/bin
	mkdir -p "$TERMUX_PREFIX/opt/kf6/cross/bin"
	cp "$TERMUX_PKG_HOSTBUILD_DIR/bin/protocolgen" \
		"$TERMUX_PREFIX/opt/kf6/cross/bin/"
}

termux_step_pre_configure() {
	# Reset hostbuild marker
	rm -rf "$TERMUX_HOSTBUILD_MARKER"
	if [[ "$TERMUX_ON_DEVICE_BUILD" == "true" ]]; then
		return
	fi
	TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" -DPROTOCOLGEN_EXECUTABLE=$TERMUX_PREFIX/opt/kf6/cross/bin/protocolgen"
}

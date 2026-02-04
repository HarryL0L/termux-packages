TERMUX_PKG_HOMEPAGE="https://invent.kde.org/pim/akonadi"
TERMUX_PKG_DESCRIPTION="Cross-desktop storage service for PIM data providing concurrent access"
TERMUX_PKG_LICENSE="LGPL-2.0-or-later"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="25.12.1"
TERMUX_PKG_SRCURL="https://download.kde.org/stable/release-service/${TERMUX_PKG_VERSION}/src/akonadi-${TERMUX_PKG_VERSION}.tar.xz"
TERMUX_PKG_SHA256="fa0ff9007e0fb1803911a2f1a5cdadf2bf3f714845a583872b787f7b52714ff0"
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="kf6-kconfig, kf6-kcoreaddons, kf6-kcrash, kf6-ki18n, kf6-kwidgetsaddons, libaccounts-qt, libc++, mariadb, qt6-qtbase"
TERMUX_PKG_BUILD_DEPENDS="extra-cmake-modules, kaccounts-integration, kf6-kconfigwidgets, kf6-kiconthemes, kf6-kitemmodels, kf6-kxmlgui, postgresql, qt6-qttools"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"

TERMUX_PKG_HOMEPAGE=https://eden-emu.dev/
TERMUX_PKG_DESCRIPTION="Nintendo Switch emulator (community fork of yuzu), Linux desktop frontend"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="@termux"
# Nightly of 2026-11-20. Bump both lines together.
_COMMIT=4089cfcffd66a0907dd8b70293b8b954527a0973
_COMMIT_DATE=20261120
TERMUX_PKG_VERSION="0.2.0+git${_COMMIT_DATE}"
TERMUX_PKG_SRCURL=git+https://git.eden-emu.dev/eden-emu/eden
TERMUX_PKG_GIT_BRANCH=master
TERMUX_PKG_SHA256=SKIP_CHECKSUM
TERMUX_PKG_AUTO_UPDATE=false
TERMUX_PKG_DEPENDS="boost, ffmpeg, libc++, liblz4, libopus, libusb, openssl, qt6-qtbase, qt6-qtcharts, sdl3, vulkan-loader, zlib, zstd"
TERMUX_PKG_BUILD_DEPENDS="boost-headers, nlohmann-json, pulseaudio, qt6-qtbase-cross-tools, qt6-qttools-cross-tools, spirv-headers, vulkan-headers, vulkan-utility-libraries"
# cubeb loads libpulse at runtime; Eden starts without it but has no sound.
TERMUX_PKG_RECOMMENDS="pulseaudio"
# 64-bit only.
TERMUX_PKG_EXCLUDED_ARCHES="arm, i686"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DQT_HOST_PATH=${TERMUX_PREFIX}/opt/qt6/cross
-DYUZU_TESTS=OFF
-DSDL3_FORCE_SYSTEM=ON
-DUSE_AAUDIO=OFF
-DUSE_OPENSL=OFF
-DUSE_AUDIOTRACK=OFF
"

termux_step_post_get_source() {
	git fetch --unshallow
	git checkout "$_COMMIT"
}

termux_step_pre_configure() {
	# CMake's `import std` support looks for libc++'s std module sources at
	# <toolchain>/../share/libc++/v1, which the Termux standalone toolchain
	# layout does not have. Link the real location there.
	local _want="${TERMUX_STANDALONE_TOOLCHAIN}/../share/libc++/v1"
	local _have
	_have=$(find "$TERMUX_STANDALONE_TOOLCHAIN" ${NDK:+"$NDK"} \
		-name std.compat.cppm -printf '%h\n' -quit 2>/dev/null || true)
	echo "std module sources: ${_have:-NOT FOUND}"
	if [ -z "$_have" ]; then
		termux_error_exit "libc++ std module sources (std.cppm) not found in the NDK"
	fi
	mkdir -p "$(dirname "$_want")"
	ln -sfn "$_have" "$_want"
}

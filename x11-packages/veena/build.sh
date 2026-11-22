TERMUX_PKG_HOMEPAGE=https://github.com/HarryL0L/Veena-music
TERMUX_PKG_DESCRIPTION="Modular music player with a living, Material You style interface"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_LICENSE_FILE="LICENSE, LICENSE-BRICKS.md"
TERMUX_PKG_MAINTAINER="@HarryL0L"
TERMUX_PKG_VERSION=0.2.0
TERMUX_PKG_SRCURL=git+https://github.com/HarryL0L/Veena-music
TERMUX_PKG_GIT_BRANCH=ccr-3f814d11-1hbsff
TERMUX_PKG_DEPENDS="fontconfig, hicolor-icon-theme, libwayland, libx11, libxcursor, libxi, libxkbcommon, libxrandr"
# Japanese, Chinese and Korean song titles and lyrics.
TERMUX_PKG_RECOMMENDS="otf-noto-sans-cjk"
TERMUX_PKG_BUILD_DEPENDS="libxcb"
TERMUX_PKG_BUILD_IN_SRC=true

# Windowing (and font) crates whose "linux" code paths should apply to
# Termux, the way alacritty and wezterm are built. fontique on Linux uses
# fontconfig, which finds Termux's fonts and falls back per script (CJK and
# so on); its Android path only reads /system/fonts without fallback. Audio (cpal -> AAudio) and system crates
# stay Android builds: AAudio works in Termux.
_WINDOWING_CRATES="winit i-slint-backend-winit i-slint-backend-selector slint
softbuffer glutin glutin_egl_sys glutin_glx_sys smithay-client-toolkit
wayland-cursor x11rb accesskit_winit arboard fontique yeslogic-fontconfig-sys"

# Runs before the *.patch files are applied: they patch vendored crates
# (after the linux/android swap), so the vendor folder must exist by then.
termux_step_post_get_source() {
	termux_setup_rust

	cargo vendor --versioned-dirs vendor > "$TERMUX_PKG_TMPDIR"/vendor-config.toml

	local name dir
	for name in $_WINDOWING_CRATES; do
		for dir in vendor/"$name"-[0-9]*; do
			[ -d "$dir" ] || continue
			find "$dir" -type f \( -name '*.rs' -o -name Cargo.toml \) -print0 | \
				xargs -0 sed -i \
				-e 's|"android"|"disabling_this_because_it_is_for_building_an_apk"|g' \
				-e 's|"linux"|"android"|g' \
				-e 's|libxkbcommon.so.0|libxkbcommon.so|g' \
				-e 's|libxkbcommon-x11.so.0|libxkbcommon-x11.so|g' \
				-e 's|libxcb.so.1|libxcb.so|g' \
				-e 's|libfontconfig.so.1|libfontconfig.so|g' \
				-e "s|\"/tmp|\"$TERMUX_PREFIX/tmp|g"
		done
	done
}

termux_step_pre_configure() {
	termux_setup_rust

	# Edited crates no longer match their file checksums; keep the
	# package checksum the lock file checks.
	local name dir
	for name in $_WINDOWING_CRATES; do
		for dir in vendor/"$name"-[0-9]*; do
			[ -f "$dir/.cargo-checksum.json" ] || continue
			sed -i 's/"files":{[^}]*}/"files":{}/' "$dir/.cargo-checksum.json"
		done
	done

	mkdir -p .cargo
	cp "$TERMUX_PKG_TMPDIR"/vendor-config.toml .cargo/config.toml

	# Audio goes through AAudio (Android 8, API 26), which isn't in the
	# API 24 sysroot Termux builds against. Link against libaaudio alone, from the NDK's API 26
	# libraries (or the device's own when building on the phone); at run
	# time Android's libaaudio.so is used.
	local aaudio_dir="$TERMUX_PKG_TMPDIR/aaudio"
	mkdir -p "$aaudio_dir"
	if [ "$TERMUX_ON_DEVICE_BUILD" = "true" ]; then
		local system_lib=/system/lib
		[ "$TERMUX_ARCH_BITS" = 64 ] && system_lib=/system/lib64
		ln -sf "$system_lib/libaaudio.so" "$aaudio_dir/libaaudio.so"
	else
		cp "$NDK/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/lib/$TERMUX_HOST_PLATFORM/26/libaaudio.so" \
			"$aaudio_dir/libaaudio.so"
	fi
	local env_host="${CARGO_TARGET_NAME//-/_}"
	export CARGO_TARGET_${env_host@U}_RUSTFLAGS+=" -L $aaudio_dir"
}

termux_step_make() {
	cargo build \
		--jobs "$TERMUX_PKG_MAKE_PROCESSES" \
		--target "$CARGO_TARGET_NAME" \
		--release \
		--offline \
		-p veena-desktop
}

termux_step_make_install() {
	install -Dm755 -t "$TERMUX_PREFIX/bin" \
		"target/$CARGO_TARGET_NAME/release/veena-desktop"
	install -Dm644 apps/desktop/veena-desktop.desktop \
		"$TERMUX_PREFIX/share/applications/veena-desktop.desktop"
	install -Dm644 apps/desktop/data/veena-music.svg \
		"$TERMUX_PREFIX/share/icons/hicolor/scalable/apps/veena-music.svg"
}

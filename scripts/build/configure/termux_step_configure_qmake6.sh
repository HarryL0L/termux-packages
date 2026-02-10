termux_step_configure_qmake6() {
        # Ensure toolchain variables (CC, CXX, CFLAGS, LDFLAGS, etc.) are set
        termux_setup_toolchain

        pushd "${TERMUX_PKG_SRCDIR}"

        # Choose qmake binary depending on build type
        if [ "$TERMUX_ON_DEVICE_BUILD" = "true" ]; then
                QMAKE_BIN="qmake6"
        else
                QMAKE_BIN="${TERMUX_PREFIX}/lib/qt6/bin/host-qmake6"
        fi

        # Run qmake with Termux toolchain variables forwarded
        "$QMAKE_BIN" \
                QMAKE_CC="$CC" \
                QMAKE_CXX="$CXX" \
                QMAKE_LINK="$CXX" \
                QMAKE_CFLAGS="$CFLAGS" \
                QMAKE_CXXFLAGS="$CXXFLAGS -isystem$TERMUX__PREFIX__INCLUDE_DIR" \
                QMAKE_LFLAGS="$LDFLAGS -L$TERMUX__PREFIX__LIB_DIR" \
                PREFIX="$TERMUX_PREFIX" \
                "$@"

        popd
}

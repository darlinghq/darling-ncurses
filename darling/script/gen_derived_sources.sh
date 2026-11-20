#!/bin/sh
# Regenerates the derived headers and sources in gen/ by running Apple's
# xcodescripts the way the Xcode project does.
#
# Run from darling/script. Needs clang, awk and unifdef on the build host.
# SDKROOT defaults to the Darling SDK of the superproject this submodule is
# checked out in.
PROJECT_DIR=$( cd ../.. ; pwd -P )
BUILT_PRODUCTS_DIR="$PROJECT_DIR/gen"
echo $PROJECT_DIR

## DARLING
# The xcodescripts expect an Xcode environment. Preprocess against Darling's
# SDK so that the generated sources see the same headers as the library build.
PLATFORM_NAME=macosx
: ${SDKROOT:="$PROJECT_DIR/../../../Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk"}
xcrun() {
	echo "clang -target x86_64-apple-macos11"
}
# /bin/sh is bash on macOS, and the generators depend on it: derived_sources.sh
# calls MKfallback.sh with fewer arguments than it shifts, which ends the
# script in shells such as dash.
sh() {
	bash "$@"
}
## /DARLING

mkdir -p "$BUILT_PRODUCTS_DIR"

echo "Executing xcodescripts/bootstrap_headers.sh"
. "$PROJECT_DIR"/xcodescripts/bootstrap_headers.sh
echo "Executing xcodescripts/bootstrap_sources.sh"
. "$PROJECT_DIR"/xcodescripts/bootstrap_sources.sh

BUILD_FLAGS="--include-directory $PROJECT_DIR/ncurses/ncurses
	--include-directory $PROJECT_DIR/ncurses/include
	--include-directory $BUILT_PRODUCTS_DIR
	-DHAVE_CONFIG_H
	-D_XOPEN_SOURCE_EXTENDED
	-D_DARWIN_C_SOURCE"
## DARLING
# make_hash and make_keys run on the build host, whose headers may lack
# Apple's availability macros.
BUILD_FLAGS="$BUILD_FLAGS
	-D__OSX_AVAILABLE(v)=
	-D__IOS_AVAILABLE(v)=
	-D__WATCHOS_AVAILABLE(v)=
	-D__TVOS_AVAILABLE(v)="
## /DARLING

echo "Build make_hash executable"
clang -o "$BUILT_PRODUCTS_DIR/make_hash" $BUILD_FLAGS \
	"$PROJECT_DIR/ncurses/ncurses/tinfo/make_hash.c"

echo "Build make_keys executable"
clang -o "$BUILT_PRODUCTS_DIR/make_keys" $BUILD_FLAGS \
	"$PROJECT_DIR/ncurses/ncurses/tinfo/make_keys.c"

echo "Executing xcodescripts/derived_headers.sh"
. "$PROJECT_DIR"/xcodescripts/derived_headers.sh
echo "Executing xcodescripts/derived_sources.sh"
. "$PROJECT_DIR"/xcodescripts/derived_sources.sh

# Based off of xcodescripts/install_headers.sh
ln -s -f "curses.h" "$BUILT_PRODUCTS_DIR/ncurses.h"

echo "Remove build-only files"
rm "$BUILT_PRODUCTS_DIR/make_hash" "$BUILT_PRODUCTS_DIR/make_keys"
# Darling's SDK has its own module map; ncurses.modulemap is not installed.
rm "$BUILT_PRODUCTS_DIR/ncurses.modulemap"

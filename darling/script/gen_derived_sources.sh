PROJECT_DIR=$( cd ../.. ; pwd -P )
BUILT_PRODUCTS_DIR="$PROJECT_DIR/gen"
echo $PROJECT_DIR

echo "Executing xcodescripts/bootstrap_headers.sh"
. "$PROJECT_DIR"/xcodescripts/bootstrap_headers.sh
echo "Executing xcodescripts/bootstrap_sources.sh"
. "$PROJECT_DIR"/xcodescripts/bootstrap_sources.sh

echo "Build make_hash executable"
clang \
    -o "$BUILT_PRODUCTS_DIR/make_hash" \
    --include-directory "$PROJECT_DIR/ncurses/ncurses" \
    --include-directory "$PROJECT_DIR/ncurses/include" \
    --include-directory "$PROJECT_DIR/gen" \
    -DMAIN_PROGRAM \
    -D_XOPEN_SOURCE_EXTENDED \
    -D_DARWIN_C_SOURCE \
    $PROJECT_DIR/ncurses/ncurses/tinfo/comp_hash.c

echo "Build make_keys executable"
clang \
    -o "$BUILT_PRODUCTS_DIR/make_keys" \
    --include-directory "$PROJECT_DIR/ncurses/ncurses" \
    --include-directory "$PROJECT_DIR/ncurses/include" \
    --include-directory "$PROJECT_DIR/gen" \
    -D_XOPEN_SOURCE_EXTENDED \
    -D_DARWIN_C_SOURCE \
    $PROJECT_DIR/ncurses/ncurses/tinfo/make_keys.c

echo "Executing xcodescripts/derived_headers.sh"
. "$PROJECT_DIR"/xcodescripts/derived_headers.sh
echo "Executing xcodescripts/derived_sources.sh"
. "$PROJECT_DIR"/xcodescripts/derived_sources.sh

# Based off of xcodescripts/install_headers.sh
ln -s -f "curses.h" "$BUILT_PRODUCTS_DIR/ncurses.h"

echo "Remove make_hash and make_keys executable"
rm "$BUILT_PRODUCTS_DIR/make_hash" "$BUILT_PRODUCTS_DIR/make_keys"
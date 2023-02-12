# src/external/ncurses/xcodescripts/run_tic.sh
PROJECT_DIR=$( cd ../.. ; pwd -P )
BUILT_PRODUCTS_DIR="$PROJECT_DIR/gen"

# sh "$PROJECT_DIR"/xcodescripts/native_execs.sh -target tic_static
mkdir -p "$BUILT_PRODUCTS_DIR/native"
clang \
    -o "$BUILT_PRODUCTS_DIR/native/tic_static" \
    --include-directory "$PROJECT_DIR/ncurses/include" \
    --include-directory "$PROJECT_DIR/ncurses/ncurses" \
    --include-directory "$PROJECT_DIR/ncurses/progs" \
    --include-directory "$PROJECT_DIR/gen" \
    -DHAVE_CONFIG_H \
    -D_XOPEN_SOURCE=600 \
    -D_XOPEN_SOURCE_EXTENDED \
    $PROJECT_DIR/ncurses/ncurses/base/key_defined.c \
    $PROJECT_DIR/ncurses/ncurses/base/keybound.c \
    $PROJECT_DIR/ncurses/ncurses/base/tries.c \
    $PROJECT_DIR/ncurses/ncurses/base/version.c \
    $PROJECT_DIR/ncurses/ncurses/tinfo/access.c \
    $PROJECT_DIR/ncurses/ncurses/tinfo/add_tries.c \
    $PROJECT_DIR/ncurses/ncurses/tinfo/alloc_entry.c \
    $PROJECT_DIR/ncurses/ncurses/tinfo/alloc_ttype.c \
    $PROJECT_DIR/ncurses/ncurses/tinfo/captoinfo.c \
    $PROJECT_DIR/ncurses/ncurses/tinfo/comp_error.c \
    $PROJECT_DIR/ncurses/ncurses/tinfo/comp_expand.c \
    $PROJECT_DIR/ncurses/ncurses/tinfo/comp_hash.c \
    $PROJECT_DIR/ncurses/ncurses/tinfo/comp_parse.c \
    $PROJECT_DIR/ncurses/ncurses/tinfo/comp_scan.c \
    $PROJECT_DIR/ncurses/ncurses/tinfo/db_iterator.c \
    $PROJECT_DIR/ncurses/ncurses/tinfo/doalloc.c \
    $PROJECT_DIR/ncurses/ncurses/tinfo/entries.c \
    $PROJECT_DIR/ncurses/ncurses/tinfo/free_ttype.c \
    $PROJECT_DIR/ncurses/ncurses/tinfo/getenv_num.c \
    $PROJECT_DIR/ncurses/ncurses/tinfo/home_terminfo.c \
    $PROJECT_DIR/ncurses/ncurses/tinfo/init_keytry.c \
    $PROJECT_DIR/ncurses/ncurses/tinfo/lib_baudrate.c \
    $PROJECT_DIR/ncurses/ncurses/tinfo/lib_cur_term.c \
    $PROJECT_DIR/ncurses/ncurses/tinfo/lib_data.c \
    $PROJECT_DIR/ncurses/ncurses/tinfo/lib_has_cap.c \
    $PROJECT_DIR/ncurses/ncurses/tinfo/lib_napms.c \
    $PROJECT_DIR/ncurses/ncurses/tinfo/lib_options.c \
    $PROJECT_DIR/ncurses/ncurses/tinfo/lib_raw.c \
    $PROJECT_DIR/ncurses/ncurses/tinfo/lib_setup.c \
    $PROJECT_DIR/ncurses/ncurses/tinfo/lib_termcap.c \
    $PROJECT_DIR/ncurses/ncurses/tinfo/lib_tparm.c \
    $PROJECT_DIR/ncurses/ncurses/tinfo/lib_tputs.c \
    $PROJECT_DIR/ncurses/ncurses/tinfo/lib_ttyflags.c \
    $PROJECT_DIR/ncurses/ncurses/tinfo/name_match.c \
    $PROJECT_DIR/ncurses/ncurses/tinfo/parse_entry.c \
    $PROJECT_DIR/ncurses/ncurses/tinfo/read_entry.c \
    $PROJECT_DIR/ncurses/ncurses/tinfo/read_termcap.c \
    $PROJECT_DIR/ncurses/ncurses/tinfo/setbuf.c \
    $PROJECT_DIR/ncurses/ncurses/tinfo/strings.c \
    $PROJECT_DIR/ncurses/ncurses/tinfo/trim_sgr0.c \
    $PROJECT_DIR/ncurses/ncurses/tinfo/write_entry.c \
    $PROJECT_DIR/ncurses/ncurses/trace/lib_trace.c \
    $PROJECT_DIR/ncurses/ncurses/trace/visbuf.c \
    $PROJECT_DIR/ncurses/progs/dump_entry.c \
    $PROJECT_DIR/ncurses/progs/tic.c \
    $BUILT_PRODUCTS_DIR/codes.c \
    $BUILT_PRODUCTS_DIR/comp_captab.c \
    $BUILT_PRODUCTS_DIR/fallback.c \
    $BUILT_PRODUCTS_DIR/lib_keyname.c \
    $BUILT_PRODUCTS_DIR/names.c \
    $BUILT_PRODUCTS_DIR/unctrl.c


DSTROOT=$BUILT_PRODUCTS_DIR
SRCROOT=$PROJECT_DIR
mkdir -p $BUILT_PRODUCTS_DIR/usr/share/terminfo/

cd $PROJECT_DIR/ncurses/misc
PATH="$BUILT_PRODUCTS_DIR/native:$PATH" \
DESTDIR="$DSTROOT" \
suffix=_static \
prefix=/usr \
exec_prefix=/usr \
bindir=/usr/bin \
datadir=/usr/share \
top_srcdir="$SRCROOT/ncurses" \
srcdir="$SRCROOT/ncurses/misc" \
/bin/sh ./run_tic.sh

rm $BUILT_PRODUCTS_DIR/native/tic_static
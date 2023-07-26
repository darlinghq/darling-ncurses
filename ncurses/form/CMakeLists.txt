project(form)

cmake_minimum_required(VERSION 3.13)
if(COMMAND cmake_policy)
  cmake_policy(SET CMP0003 NEW)
endif(COMMAND cmake_policy)

include_directories(${CMAKE_CURRENT_SOURCE_DIR})
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/../menu)

set(form_sources
    fld_arg.c
    fld_attr.c
    fld_current.c
    fld_def.c
    fld_dup.c
    fld_ftchoice.c
    fld_ftlink.c
    fld_info.c
    fld_just.c
    fld_link.c
    fld_max.c
    fld_move.c
    fld_newftyp.c
    fld_opts.c
    fld_pad.c
    fld_page.c
    fld_stat.c
    fld_type.c
    fld_user.c
    frm_cursor.c
    frm_data.c
    frm_def.c
    frm_driver.c
    frm_hook.c
    frm_opts.c
    frm_page.c
    frm_post.c
    frm_req_name.c
    frm_scale.c
    frm_sub.c
    frm_user.c
    frm_win.c
    fty_alnum.c
    fty_alpha.c
    fty_enum.c
    fty_int.c
    fty_ipv4.c
    fty_num.c
    fty_regex.c
)

set(DYLIB_INSTALL_NAME "/usr/lib/libform.5.4.dylib")
add_darling_library(form SHARED ${form_sources})
target_link_libraries(form system ncurses)
set_target_properties(form PROPERTIES OUTPUT_NAME "form.5.4")
make_fat(form)

InstallSymlink("libform.5.4.dylib" "${CMAKE_INSTALL_PREFIX}/libexec/darling/usr/lib/libform.dylib")

install(TARGETS form DESTINATION libexec/darling/usr/lib)

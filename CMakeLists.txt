project(ncurses-top)

cmake_minimum_required(VERSION 3.10)

add_definitions(-nostdinc)
set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -nostdlib")

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/ncurses/include)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/ncurses/ncurses)

add_definitions(-D _XOPEN_SOURCE_EXTENDED=1)
#add_definitions(-DTRACE)

# Hide warnings
add_definitions(
	-Wno-format-security
)

set(DYLIB_COMPAT_VERSION "5.4.0")
set(DYLIB_CURRENT_VERSION "5.4.0")

add_subdirectory(ncurses/ncurses)
add_subdirectory(ncurses/menu)
add_subdirectory(ncurses/panel)

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/ncurses/progs)
add_darling_executable(clear ncurses/progs/clear.c)
target_link_libraries(clear ncurses)

add_darling_object_library(nc_dump_entry ncurses/progs/dump_entry.c)

add_darling_executable(infocmp ncurses/progs/infocmp.c $<TARGET_OBJECTS:nc_dump_entry>)
target_link_libraries(infocmp ncurses)

add_darling_executable(tic ncurses/progs/tic.c $<TARGET_OBJECTS:nc_dump_entry>)
target_link_libraries(tic ncurses)

add_darling_executable(toe ncurses/progs/toe.c)
target_link_libraries(toe ncurses)

add_darling_executable(tput ncurses/progs/tput.c)
target_link_libraries(tput ncurses)

add_darling_executable(tset ncurses/progs/tset.c)
target_link_libraries(tset ncurses)

InstallSymlink(tset ${CMAKE_INSTALL_PREFIX}/libexec/darling/usr/bin/reset)
InstallSymlink(captoinfo ${CMAKE_INSTALL_PREFIX}/libexec/darling/usr/bin/tic)
InstallSymlink(infotocap ${CMAKE_INSTALL_PREFIX}/libexec/darling/usr/bin/tic)

install(TARGETS clear infocmp tic toe tput tset DESTINATION libexec/darling/usr/bin)

install(DIRECTORY terminfo DESTINATION libexec/darling/usr/share)

AC_INIT([template], [1.0], [])
AM_INIT_AUTOMAKE([-Wall -Werror foreign])
AC_PROG_CXX
AC_CONFIG_SRCDIR([src/main.cpp])
AC_CONFIG_HEADERS([config.h])
AC_CONFIG_FILES([
 Makefile
 src/Makefile
])
AC_CONFIG_COMMANDS([googletest],
[cd ../external/googletest && \
	mkdir -pv build && \
	cd build && \
	cmake .. && \
	make],
)
AC_OUTPUT
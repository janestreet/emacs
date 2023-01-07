# gettime.m4 serial 12
dnl Copyright (C) 2002, 2004-2006, 2009-2023 Free Software Foundation, Inc.
dnl This file is free software; the Free Software Foundation
dnl gives unlimited permission to copy and/or distribute it,
dnl with or without modifications, as long as this notice is preserved.

AC_DEFUN([gl_GETTIME],
[
  dnl Prerequisites of lib/gettime.c.
  AC_REQUIRE([gl_CLOCK_TIME])
  AC_REQUIRE([gl_TIMESPEC])

  AC_REQUIRE([gl_CHECK_FUNC_TIMESPEC_GET])
  if test $gl_cv_func_timespec_get = yes; then
    AC_DEFINE([HAVE_TIMESPEC_GET], [1],
      [Define if you have the timespec_get function.])
  fi
])

dnl Tests whether the function timespec_get exists.
dnl Sets gl_cv_func_timespec_get.
AC_DEFUN([gl_CHECK_FUNC_TIMESPEC_GET],
[
  dnl Persuade OpenBSD <time.h> to declare timespec_get().
  AC_REQUIRE([gl_USE_SYSTEM_EXTENSIONS])

  dnl We can't use AC_CHECK_FUNC here, because timespec_get() is defined as a
  dnl static inline function in <time.h> on MSVC 14.
  AC_CACHE_CHECK([for timespec_get], [gl_cv_func_timespec_get],
    [AC_LINK_IFELSE(
       [AC_LANG_PROGRAM(
          [[#include <time.h>
            struct timespec ts;
          ]],
          [[return timespec_get (&ts, 0);]])
       ],
       [gl_cv_func_timespec_get=yes],
       [gl_cv_func_timespec_get=no])
    ])
])

AC_DEFUN([gl_GETTIME_RES],
[
  dnl Prerequisites of lib/gettime-res.c.
  AC_REQUIRE([gl_CLOCK_TIME])
  AC_REQUIRE([gl_TIMESPEC])
  AC_CHECK_FUNCS_ONCE([timespec_getres])
])

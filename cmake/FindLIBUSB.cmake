# - Try to find the freetype library
# Once done this defines
#
#  LIBUSB_FOUND - system has libusb
#  LIBUSB_INCLUDE_DIR - the libusb include directory
#  LIBUSB_LIBRARIES - Link these to use libusb

# Copyright (c) 2006, 2008  Laurent Montel, <montel@kde.org>
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.

# use pkg-config to get the directories and then use these values
# in the FIND_PATH() and FIND_LIBRARY() calls
find_package(PkgConfig)
pkg_check_modules(PC_LIBUSB libusb-1.0)

find_path(LIBUSB_INCLUDE_DIR libusb.h
  PATH_SUFFIXES libusb-1.0
  PATHS ${PC_LIBUSB_INCLUDEDIR} ${PC_LIBUSB_INCLUDE_DIRS})

find_library(LIBUSB_LIBRARY NAMES usb-1.0
  PATHS ${PC_LIBUSB_LIBDIR} ${PC_LIBUSB_LIBRARY_DIRS})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(LIBUSB DEFAULT_MSG LIBUSB_LIBRARY LIBUSB_INCLUDE_DIR)

if (LIBUSB_FOUND)
  set(LIBUSB_LIBRARIES ${LIBUSB_LIBRARY})
  set(LIBUSB_INCLUDE_DIRS ${LIBUSB_INCLUDE_DIR})
  set(LIBUSB_VERSION ${PC_LIBUSB_VERSION})
  if (NOT TARGET LIBUSB::LIBUSB)
    add_library(LIBUSB::LIBUSB UNKNOWN IMPORTED)
    set_target_properties(LIBUSB::LIBUSB PROPERTIES
            IMPORTED_LOCATION "${LIBUSB_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${LIBUSB_INCLUDE_DIR}"
            )
  endif()
endif()

mark_as_advanced(LIBUSB_INCLUDE_DIR LIBUSB_LIBRARY)

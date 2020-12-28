find_package(PkgConfig)
pkg_check_modules(PC_libusb libusb-1.0)

find_path(libusb_INCLUDE_DIR libusb.h
  PATH_SUFFIXES libusb-1.0
  PATHS ${PC_libusb_INCLUDEDIR} ${PC_libusb_INCLUDE_DIRS})

find_library(libusb_LIBRARY NAMES usb-1.0
  PATHS ${PC_libusb_LIBDIR} ${PC_libusb_LIBRARY_DIRS})
mark_as_advanced(libusb_INCLUDE_DIR libusb_LIBRARY)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(libusb DEFAULT_MSG libusb_LIBRARY libusb_INCLUDE_DIR)

if (libusb_FOUND AND NOT TARGET libusb::libusb)
    add_library(libusb::libusb UNKNOWN IMPORTED)
    set_target_properties(libusb::libusb PROPERTIES
            IMPORTED_LOCATION "${libusb_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${libusb_INCLUDE_DIR}"
            )
endif()


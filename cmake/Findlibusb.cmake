find_package(PkgConfig)
pkg_check_modules(PC_LibUSB libusb-1.0)

find_path(LibUSB_INCLUDE_DIR libusb.h
  PATH_SUFFIXES libusb-1.0
  PATHS ${PC_LibUSB_INCLUDEDIR} ${PC_LibUSB_INCLUDE_DIRS})

find_library(LibUSB_LIBRARY NAMES usb-1.0
  PATHS ${PC_LibUSB_LIBDIR} ${PC_LibUSB_LIBRARY_DIRS})
mark_as_advanced(LibUSB_INCLUDE_DIR LibUSB_LIBRARY)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(LibUSB DEFAULT_MSG LibUSB_LIBRARY LibUSB_INCLUDE_DIR)

if (LibUSB_FOUND AND NOT TARGET LibUSB::LibUSB)
    add_library(LibUSB::LibUSB UNKNOWN IMPORTED)
    set_target_properties(LibUSB::LibUSB PROPERTIES
            IMPORTED_LOCATION "${LibUSB_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${LibUSB_INCLUDE_DIR}"
            )
endif()


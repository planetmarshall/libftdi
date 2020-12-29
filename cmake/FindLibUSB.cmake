find_package(PkgConfig)
pkg_check_modules(PC_LibUSB libusb-1.0)

find_path(LibUSB_INCLUDE_DIR libusb.h PATH_SUFFIXES libusb-1.0 PATHS ${PC_LibUSB_INCLUDE_DIRS})
find_library(LibUSB_LIBRARY NAMES usb-1.0 PATHS ${PC_LibUSB_LIBRARY_DIRS})
mark_as_advanced(LibUSB_INCLUDE_DIR LibUSB_LIBRARY)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(LibUSB DEFAULT_MSG LibUSB_LIBRARY LibUSB_INCLUDE_DIR)

if (LibUSB_FOUND AND NOT TARGET LibUSB::LibUSB)
    add_library(LibUSB::LibUSB INTERFACE IMPORTED)
    set(_libusb_libraries ${LibUSB_LIBRARY})
    if (UNIX)
        find_package(Threads)
        list(APPEND _libusb_libraries Threads::Threads)
        if (NOT APPLE)
            list(APPEND _libusb_libraries udev)
        endif()
    endif()
    set_target_properties(LibUSB::LibUSB PROPERTIES
            INTERFACE_LINK_LIBRARIES "${_libusb_libraries}"
            INTERFACE_INCLUDE_DIRECTORIES "${LibUSB_INCLUDE_DIR}"
    )

endif()


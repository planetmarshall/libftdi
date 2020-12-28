find_package(PkgConfig)
pkg_check_modules(PC_LibConfuse libconfuse)

find_path(LibConfuse_INCLUDE_DIR confuse.h
        PATHS ${PC_LibConfuse_INCLUDEDIR} ${PC_LibConfuse_INCLUDE_DIRS})

find_library(LibConfuse_LIBRARY NAMES confuse
        PATHS ${PC_LibConfuse_LIBDIR} ${PC_LibConfuse_LIBRARY_DIRS})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(LibConfuse DEFAULT_MSG LibConfuse_LIBRARY LibConfuse_INCLUDE_DIR)

if (LibConfuse_FOUND AND NOT TARGET LibConfuse::LibConfuse)
  add_library(LibConfuse::LibConfuse UNKNOWN IMPORTED)
  set_target_properties(LibConfuse::LibConfuse PROPERTIES
          IMPORTED_LOCATION "${LibConfuse_LIBRARY}"
          INTERFACE_INCLUDE_DIRECTORIES "${LibConfuse_INCLUDE_DIR}"
          )
endif()

mark_as_advanced(LibConfuse_INCLUDE_DIR LibConfuse_LIBRARY)

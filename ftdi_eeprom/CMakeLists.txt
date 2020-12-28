find_package ( LibConfuse REQUIRED )
find_package ( Libintl )

# determine docdir
include(GNUInstallDirs)
if(NOT CMAKE_INSTALL_DOCDIR)
  if(WIN32)
    set(CMAKE_INSTALL_DOCDIR .)
  else(WIN32)
    set(CMAKE_INSTALL_DOCDIR ${CMAKE_INSTALL_DATAROOTDIR}/doc/${PROJECT_NAME})
  endif(WIN32)
endif(NOT CMAKE_INSTALL_DOCDIR)

message(STATUS "Building ftdi_eeprom")

list ( APPEND libs ${CONFUSE_LIBRARIES} )

if ( LIBINTL_FOUND )
  include_directories ( ${LIBINTL_INCLUDE_DIR} )
  list ( APPEND libs ${LIBINTL_LIBRARIES} )
endif ()


# Version defines
set ( EEPROM_MAJOR_VERSION 0 )
set ( EEPROM_MINOR_VERSION 17 )
set ( EEPROM_VERSION_STRING ${EEPROM_MAJOR_VERSION}.${EEPROM_MINOR_VERSION} )

configure_file(
               ftdi_eeprom_version.h.in
              ${CMAKE_CURRENT_BINARY_DIR}/ftdi_eeprom_version.h
)

add_executable ( ftdi_eeprom main.c )
target_link_libraries ( ftdi_eeprom
        PRIVATE
        LibFTDI::ftdi1
        LibConfuse::LibConfuse
        LibUSB::LibUSB
        )
target_include_directories(ftdi_eeprom PRIVATE ${CMAKE_CURRENT_BINARY_DIR})

if ( LIBINTL_FOUND )
  target_link_libraries ( ftdi_eeprom ${LIBINTL_LIBRARIES} )
endif ()
install ( TARGETS ftdi_eeprom DESTINATION bin )
install ( FILES example.conf DESTINATION ${CMAKE_INSTALL_DOCDIR} )

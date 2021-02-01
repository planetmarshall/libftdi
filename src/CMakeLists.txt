
# Version information
set(SNAPSHOT_VERSION "unknown")
execute_process(COMMAND git describe
                OUTPUT_VARIABLE GIT_DESCRIBE_OUTPUT
                RESULT_VARIABLE GIT_DESCRIBE_RESULT
                ERROR_QUIET
                OUTPUT_STRIP_TRAILING_WHITESPACE
                )
if(${GIT_DESCRIBE_RESULT} STREQUAL 0)
  set(SNAPSHOT_VERSION ${GIT_DESCRIBE_OUTPUT})
endif()
message(STATUS "Detected git snapshot version: ${SNAPSHOT_VERSION}")

configure_file(ftdi_version_i.h.in "${CMAKE_CURRENT_BINARY_DIR}/ftdi_version_i.h" @ONLY)

# Targets
set(c_sources
  ftdi.c
  ftdi_stream.c
)

set(c_headers
  ftdi.h
  "${CMAKE_CURRENT_BINARY_DIR}/ftdi_version_i.h"
)

add_library(ftdi1 ${c_sources} ${c_headers})
add_library(LibFTDI::ftdi1 ALIAS ftdi1)
target_include_directories(ftdi1 PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}>
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
        $<INSTALL_INTERFACE:include/libftdi1>
        )
if (MSVC)
	target_include_directories(ftdi1 PUBLIC
        	$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/posix>
        	$<INSTALL_INTERFACE:include/libftdi1/posix>
        )
endif()

math(EXPR VERSION_FIXUP "${MAJOR_VERSION} + 1")    # Compatibility with previous releases
set_target_properties(ftdi1 PROPERTIES VERSION ${VERSION_FIXUP}.${MINOR_VERSION}.0 SOVERSION 2)
# Prevent clobbering each other during the build
set_target_properties ( ftdi1 PROPERTIES CLEAN_DIRECT_OUTPUT 1 )

target_link_libraries(ftdi1 PRIVATE LibUSB::LibUSB)

install ( TARGETS ftdi1
          RUNTIME DESTINATION bin
          LIBRARY DESTINATION lib${LIB_SUFFIX}
          ARCHIVE DESTINATION lib${LIB_SUFFIX}
        )

install ( FILES ${c_headers}
          DESTINATION include/${PROJECT_NAME}
          COMPONENT headers
        )

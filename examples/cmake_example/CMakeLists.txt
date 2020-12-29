cmake_minimum_required ( VERSION 3.0 )
project ( example C )

find_package ( LibFTDI NO_MODULE REQUIRED )

add_executable ( example main.c )
target_link_libraries( example PRIVATE LibFTDI::ftdi1 )

install ( TARGETS example DESTINATION bin )
          

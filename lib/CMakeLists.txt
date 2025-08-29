cmake_minimum_required(VERSION 3.4.1)
include_directories( playfair llhttp )

aux_source_directory(. play_src)
set(DIR_SRCS ${play_src})

add_library( airplay
        STATIC
        ${DIR_SRCS}
        )

find_library( LIBPLIST NAMES plist plist-2.0 )

if( WIN32 )
    # Windows configuration
    if( LIBPLIST )
        target_link_libraries( airplay
            playfair
            llhttp
            ${LIBPLIST} )
        message(STATUS "Found libplist: ${LIBPLIST}")
    else()
        target_link_libraries( airplay
            playfair
            llhttp )
        message(WARNING "libplist not found. Some functionality may be limited.")
    endif()
    
    # Try to find OpenSSL
    find_package(OpenSSL)
    if(OPENSSL_FOUND)
        target_link_libraries( airplay OpenSSL::Crypto )
    else()
        message(WARNING "OpenSSL not found. You may need to install OpenSSL for Windows.")
    endif()
    
elseif( UNIX AND NOT APPLE )
    if( LIBPLIST )
        target_link_libraries( airplay
            pthread
            playfair
            llhttp
            ${LIBPLIST} )
    else()
        target_link_libraries( airplay
            pthread
            playfair
            llhttp )
        message(WARNING "libplist not found. Some functionality may be limited.")
    endif()
    
    find_package(OpenSSL 1.1.1 REQUIRED)
    target_compile_definitions(airplay PUBLIC OPENSSL_API_COMPAT=0x10101000L)
    target_link_libraries( airplay OpenSSL::Crypto )
    target_link_libraries( airplay dns_sd )
else()
    # macOS configuration
    if( LIBPLIST )
        target_link_libraries( airplay
            pthread
            playfair
            llhttp
            ${LIBPLIST} )
    else()
        target_link_libraries( airplay
            pthread
            playfair
            llhttp )
        message(WARNING "libplist not found. Some functionality may be limited.")
    endif()
        
    include_directories( /usr/local/opt/openssl@1.1/include/ )
    target_link_libraries( airplay /usr/local/opt/openssl@1.1/lib/libcrypto.a )
endif()
        

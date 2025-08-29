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
    target_link_libraries( airplay
        playfair
        llhttp
        ${LIBPLIST} )
    
    # Try to find OpenSSL
    find_package(OpenSSL)
    if(OPENSSL_FOUND)
        target_link_libraries( airplay OpenSSL::Crypto )
    else()
        message(WARNING "OpenSSL not found. You may need to install OpenSSL for Windows.")
    endif()
    
elseif( UNIX AND NOT APPLE )
    target_link_libraries( airplay
        pthread
        playfair
        llhttp
        ${LIBPLIST} )
    
    find_package(OpenSSL 1.1.1 REQUIRED)
    target_compile_definitions(airplay PUBLIC OPENSSL_API_COMPAT=0x10101000L)
    target_link_libraries( airplay OpenSSL::Crypto )
    target_link_libraries( airplay dns_sd )
else()
    # macOS configuration
    target_link_libraries( airplay
        pthread
        playfair
        llhttp
        ${LIBPLIST} )
        
    include_directories( /usr/local/opt/openssl@1.1/include/ )
    target_link_libraries( airplay /usr/local/opt/openssl@1.1/lib/libcrypto.a )
endif()
        

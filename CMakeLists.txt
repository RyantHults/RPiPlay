cmake_minimum_required(VERSION 3.4.1)

set(default_build_type "Release")
if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
	set(CMAKE_BUILD_TYPE "${default_build_type}" CACHE
		STRING "Choose the type of build." FORCE)
	set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS
		"Debug" "Release" "MinSizeRel" "RelWithDebInfo")
endif()

project(rpiplay)

set (CMAKE_CXX_STANDARD 11)

set (RENDERER_FLAGS "")

# Windows-specific configuration
if(WIN32)
    # Add Windows-specific definitions
    add_definitions(-DWIN32_LEAN_AND_MEAN)
    add_definitions(-D_CRT_SECURE_NO_WARNINGS)
    
    # Link against Windows libraries
    set(WINDOWS_LIBS ws2_32 iphlpapi)
endif()

add_subdirectory(lib/playfair)
add_subdirectory(lib/llhttp)
add_subdirectory(lib)
add_subdirectory(renderers)

# Make sure the main executable is aware of the available renderers
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${RENDERER_FLAGS}" )

add_executable( rpiplay rpiplay.cpp)

if(WIN32)
    target_link_libraries ( rpiplay renderers airplay ${WINDOWS_LIBS} )
else()
    target_link_libraries ( rpiplay renderers airplay )
endif()

install(TARGETS rpiplay RUNTIME DESTINATION bin)

cmake_minimum_required(VERSION 3.14)
project (TaoQuick LANGUAGES CXX)

SET(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

# use c++11
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
# use test
#enable_testing()

if (NOT PROJECT_BINARY_DIR)
	set(PROJECT_BINARY_DIR build)
endif()
#if (NOT QT_DIR)
#	set(QT_DIR "E:/qt5-install/lib/cmake/Qt6")
#endif()
#if (NOT Qt5_DIR)
#        set(Qt5_DIR ${QT_DIR})
#endif()
#if (NOT Qt6_DIR)
#        set(Qt6_DIR ${QT_DIR})
#endif()
set (EXECUTABLE_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/bin)
set (LIBRARY_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/bin)

if (NOT CMAKE_BUILD_TYPE) 
    set(CMAKE_BUILD_TYPE "Release")
endif()
message("Build Type " ${CMAKE_BUILD_TYPE})


set_property(GLOBAL PROPERTY USE_FOLDERS ON)
add_compile_options("$<$<C_COMPILER_ID:MSVC>:/utf-8>")
add_compile_options("$<$<CXX_COMPILER_ID:MSVC>:/utf-8>")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /UMBCS /D_UNICODE /DUNICODE")

add_subdirectory(examples)

#if (NOT CMAKE_NO_BUILD_TEST) 
#    add_subdirectory(test)
#endif()

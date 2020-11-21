find_package(Git)
if(Git_FOUND)
    message("Git found: ${GIT_EXECUTABLE}")
endif()

set (REVISION "0000000000")
execute_process(
    COMMAND ${GIT_EXECUTABLE} rev-parse HEAD
    WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
    OUTPUT_VARIABLE OUTPUT)
if (OUTPUT)
    string(SUBSTRING ${OUTPUT} 0 10 REVISION)
endif()
message("REVISION ${REVISION}")
add_compile_definitions(TaoREVISIONSTR="${REVISION}")

set (TAG "0.0.0.0")
execute_process(
    COMMAND ${GIT_EXECUTABLE} describe --abbrev=0 --tags
    WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
    OUTPUT_VARIABLE OUTPUT)
if(OUTPUT)
    string(STRIP ${OUTPUT} TAG)
endif()    
message("TAG ${TAG}")
add_compile_definitions(TaoVer="${TAG}")
string(REPLACE "." ";" VERSION_LIST ${TAG})
list(GET VERSION_LIST 0 TAG_VERSION_MAJOR)
list(GET VERSION_LIST 1 TAG_VERSION_MINOR)
list(GET VERSION_LIST 2 TAG_VERSION_PATCH)
add_compile_definitions(TaoMAJ=${TAG_VERSION_MAJOR})
add_compile_definitions(TaoMIN=${TAG_VERSION_MINOR})
add_compile_definitions(TaoPAT=${TAG_VERSION_PATCH})

string(TIMESTAMP DateTime "%Y-%m-%d %H:%M:%S")
add_compile_definitions(TaoDATETIME="${DateTime}")
add_compile_definitions(CXX_COMPILER_ID="${CMAKE_CXX_COMPILER_ID}")

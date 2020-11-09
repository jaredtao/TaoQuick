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
add_definitions(TaoREVISION=${REVISION})
add_definitions(TaoREVISION="\"${REVISION}\"")

set (TAG "0.0.0.0")
execute_process(
    COMMAND ${GIT_EXECUTABLE} describe --abbrev=0 --tags
    WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
    OUTPUT_VARIABLE TAG)
message("TAG ${TAG}")
add_definitions(TaoVer="\"${TAG}\"")

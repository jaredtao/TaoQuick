set(TaoCommonPath ${CMAKE_CURRENT_SOURCE_DIR} PARENT_SCOPE)
file(GLOB_RECURSE files *.h *.hpp *.cpp *.c)
set(TaoCommonFiles ${files} PARENT_SCOPE)
message("TaoCommonFiles ${TaoCommonFiles}")

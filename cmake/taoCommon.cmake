set(TaoCommonPath ${CMAKE_SOURCE_DIR}/3rdparty/TaoCommon)

#file(GLOB_RECURSE TaoCommonFiles *.hpp *.cpp *.c)

aux_source_directory(${TaoCommonPath} TaoCommonFiles)
message("TaoCommonFiles ${TaoCommonFiles}")


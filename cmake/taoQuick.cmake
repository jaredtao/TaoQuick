set(TaoQuickPath ${CMAKE_SOURCE_DIR}/src/TaoQuick/imports)

if (CMAKE_BUILD_TYPE MATCHES "Release")
    set(TaoQuickRes ${TaoQuickPath}/TaoQuick/TaoQuick.qrc CACHE STRING "tao quick res path")
    add_compile_definitions(TaoQuickImportPath="qrc:///")
    add_compile_definitions(TaoQuickImagePath="qrc:/TaoQuick/Images/")
else()
    add_compile_definitions(TaoQuickImportPath="file:///${TaoQuickPath}")
    add_compile_definitions(TaoQuickImagePath="file:///${TaoQuickPath}/TaoQuick/Images/")
endif()
add_compile_definitions(QML_IMPORT_PATH="${TaoQuickPath}")
add_compile_definitions(QML2_IMPORT_PATH="${TaoQuickPath}")
add_compile_definitions(QML_DESIGNER_IMPORT_PATH="${TaoQuickPath}")



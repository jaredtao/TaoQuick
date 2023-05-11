set(TaoQuickPath ${CMAKE_SOURCE_DIR}/src)

if (CMAKE_BUILD_TYPE MATCHES "Release")
    set(TaoQuickRes ${TaoQuickPath}/TaoQuick/TaoQuick.qrc CACHE STRING "tao quick res path")
    set(TaoQuickImport "qrc:///" CACHE STRING "tao quick import path")
else()
    set(TaoQuickImport "file:///${TaoQuickPath}/" CACHE STRING "tao quick import path")
endif()

add_compile_definitions(TaoQuickImport="${TaoQuickImport}")
add_compile_definitions(TaoQuickImage="${TaoQuickImage}")

add_compile_definitions(TaoQuickImportPath="${TaoQuickImport}")

add_compile_definitions(QML_IMPORT_PATH="${TaoQuickPath}")
add_compile_definitions(QML2_IMPORT_PATH="${TaoQuickPath}")
add_compile_definitions(QML_DESIGNER_IMPORT_PATH="${TaoQuickPath}")


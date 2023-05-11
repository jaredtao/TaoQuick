set(TaoQuickPath ${CMAKE_CURRENT_LIST_DIR})

if (CMAKE_BUILD_TYPE MATCHES "Release")
    set(TaoQuickRes ${TaoQuickPath}/TaoQuick/TaoQuick.qrc CACHE STRING "tao quick res path")
    set(TaoQuickImportPath "qrc:///" CACHE STRING "tao quick import path")
else()
    set(TaoQuickImportPath "file:///${TaoQuickPath}/" CACHE STRING "tao quick import path")
endif()

add_compile_definitions(TaoQuickImportPath="${TaoQuickImportPath}")

#add_compile_definitions(QML_IMPORT_PATH="${TaoQuickPath}")
#add_compile_definitions(QML2_IMPORT_PATH="${TaoQuickPath}")
#add_compile_definitions(QML_DESIGNER_IMPORT_PATH="${TaoQuickPath}")

set(QML_IMPORT_PATH ${TaoQuickPath} CACHE STRING "")
set(QML2_IMPORT_PATH ${TaoQuickPath} CACHE STRING "")
set(QML_DESIGNER_IMPORT_PATH ${TaoQuickPath} CACHE STRING "")

CONFIG(debug,debug|release){
    # debug mode use local file
    DEFINES += TaoQuickImportPath=\\\"file:///$$PWD\\\"
    DEFINES += TaoQuickImagePath=\\\"file:///$$PWD/TaoQuick/Images/\\\"
} else {
    # release mode use qrc file
    RESOURCES += $$PWD/TaoQuick/TaoQuick.qrc
    # release mode set importPath with 'qrc:///'
    DEFINES += TaoQuickImportPath=\\\"qrc:///\\\"
    DEFINES += TaoQuickImagePath=\\\"qrc:/TaoQuick/Images/\\\"
}

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH	= $$PWD
QML2_IMPORT_PATH = $$PWD

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH = $$PWD


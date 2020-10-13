CONFIG(debug,debug|release){
    DEFINES += TaoQuickImportPath=\\\"file:///$$PWD\\\"
} else {
    RESOURCES += $$PWD/TaoQuick/TaoQuick.qrc
    DEFINES += TaoQuickImportPath=\\\"qrc:///\\\"
}

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH	= $$PWD
QML2_IMPORT_PATH = $$PWD

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH = $$PWD


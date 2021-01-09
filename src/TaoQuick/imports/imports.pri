CONFIG(debug,debug|release){
    # debug mode use local file
    win32{
        path=$$system("cd")
        path ~=s,\\\\,/,g
    } else {
        path=$$system("pwd")
    }
    TaoQuickImport=\"file:///$$path\"
    TaoQuickImage=\"file:///$$path/TaoQuick/Images/\"
    DEFINES += TaoQuickImportPath=\\\"file:///$${path}\\\"
    DEFINES += TaoQuickImagePath=\\\"file:///$${path}/TaoQuick/Images/\\\"
} else {
    # release mode use qrc file
    RESOURCES += $$PWD/TaoQuick/TaoQuick.qrc
    # release mode set importPath with 'qrc:///'
    TaoQuickImport=\"qrc:/\"
    TaoQuickImage=\"qrc:/TaoQuick/Images/\"
    DEFINES += TaoQuickImportPath=\\\"qrc:///\\\"
    DEFINES += TaoQuickImagePath=\\\"qrc:/TaoQuick/Images/\\\"
}

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH	= $$PWD
QML2_IMPORT_PATH = $$PWD

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH = $$PWD


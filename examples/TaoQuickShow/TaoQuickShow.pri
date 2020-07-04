CONFIG += file_copies

HEADERS += \
    $$PWD/Src/TaoObject.h \
    $$PWD/Src/TaoFramework.h \
    $$PWD/Src/TaoView.h \
    $$PWD/Src/Trans.h \
    $$PWD/Src/AppInfo.h

SOURCES += \
    $$PWD/Src/TaoFramework.cpp \
    $$PWD/Src/TaoView.cpp \
    $$PWD/Src/Trans.cpp \
    $$PWD/Src/AppInfo.cpp \
    $$PWD/Src/main.cpp

CONFIG(debug, debug|release) {
    #debug模式直接用本地qml文件,不要qrc资源文件。这样调试快一些。
    DEFINES += qmlPath=\\\"file:///$$PWD/Qml/\\\"
    DEFINES += contentsPath=\\\"file:///$$PWD/Contents/\\\"
    DEFINES += imgPath=\\\"file:///$$PWD/Image/\\\"
} else {
    #release模式用qrc、走资源文件。这样发布不会携带源码。
    RESOURCES += \
        $$PWD/Qml.qrc \
        $$PWD/Image.qrc \
        $$PWD/Contents.qrc

    DEFINES += qmlPath=\\\"qrc:/Qml/\\\"
    DEFINES += contentsPath=\\\"qrc:/Contents/\\\"
    DEFINES += imgPath=\\\"qrc:/Image/\\\"
}

!android {
    trans.files = $$files($$_PRO_FILE_PWD_/Trans/language_*.json)
    trans.path = $$DESTDIR/Trans
    COPIES += trans
}

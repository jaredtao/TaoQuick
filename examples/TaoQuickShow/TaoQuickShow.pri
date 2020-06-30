QT += qml quick

CONFIG += plugin c++14 qtquickcompiler

CONFIG += file_copies

#msvc {
#    HEADERS += $$PWD/Ver-u16.h
#    DEFINES += VER_Utf16
#} else {
#    HEADERS += $$PWD/Ver-u8.h
#}

msvc {
    QMAKE_CFLAGS += -source-charset:utf-8
    QMAKE_CXXFLAGS += -source-charset:utf-8
}
#一部分头文件加入编译预处理，提高编译速度
msvc | gcc | xcode {
    CONFIG += precompile_header
    PRECOMPILED_HEADER = $$PWD/Src/stdafx.h
}

include($${TaoQuick_3RDPARTY_TREE}/TaoCommon/TaoCommon.pri)

HEADERS += \
    $$PWD/Src/TaoView.h \
    $$PWD/Src/Trans.h \

SOURCES += \
    $$PWD/Src/TaoView.cpp \
    $$PWD/Src/Trans.cpp \
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

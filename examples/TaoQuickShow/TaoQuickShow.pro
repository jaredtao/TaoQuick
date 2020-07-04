TEMPLATE = app
TARGET = TaoQuickApp

QT += qml quick concurrent

CONFIG += plugin c++17 qtquickcompiler utf8_source

load(taoVersion)

load(taoBundle)
BundlePath = $$getBundlePath("TaoQuickApp")

load(taoBuildPath)
setBuildPath($${TaoQuick_BUILD_TREE}/$${TARGET})

CONFIG(debug,debug|release) {
    DESTDIR = $${TaoQuick_RUN_TREE}/debug
} else {
    DESTDIR = $${TaoQuick_RUN_TREE}/release
}
#msvc {
#    HEADERS += $$PWD/Ver-u16.h
#    DEFINES += VER_Utf16
#} else {
#    HEADERS += $$PWD/Ver-u8.h
#}

#msvc {
#    QMAKE_CFLAGS += -source-charset:utf-8
#    QMAKE_CXXFLAGS += -source-charset:utf-8
#}
#一部分头文件加入编译预处理，提高编译速度
msvc | gcc | xcode {
    CONFIG += precompile_header
    PRECOMPILED_HEADER = $$PWD/Src/stdafx.h
}

include($${TaoQuick_3RDPARTY_TREE}/3rdparty.pri)

include(TaoQuickShow.pri)

win32:!mingw {
    RC_FILE = App.rc
}
macos {
    ICON = milk.icns
}

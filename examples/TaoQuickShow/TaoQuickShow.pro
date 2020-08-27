TEMPLATE = app
TARGET = TaoQuickApp

QT += qml quick concurrent

CONFIG += plugin c++17 qtquickcompiler utf8_source

load(taoVersion)
setTaoVersion()

load(taoBundle)
BundlePath = $$getBundlePath("TaoQuickApp")

load(taoBuildPath)
setBuildPath($${TaoQuick_BUILD_TREE}/$${TARGET})

CONFIG(debug,debug|release) {
    DESTDIR = $${TaoQuick_RUN_TREE}/debug
    DEFINES += TAODEBUG
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

include($${TaoQuick_3RDPARTY_TREE}/3rdparty.pri)

include(TaoQuickShow.pri)

win32:!mingw {
    RC_FILE = App.rc
}
macos {
    ICON = milk.icns
}

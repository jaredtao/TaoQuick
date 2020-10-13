TEMPLATE = app
TARGET = TaoQuickApp

QT += qml quick

CONFIG += c++17 qtquickcompiler utf8_source

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

include($${TaoQuick_3RDPARTY_TREE}/3rdparty.pri)
include($${TaoQuick_SOURCE_TREE}/src/TaoQuick/TaoQuick.pri)
include(TaoQuickShow.pri)

win32:!mingw {
    RC_FILE = App.rc
}
macos {
    ICON = milk.icns
}

TEMPLATE = app
TARGET = TaoQuickApp

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

include(TaoQuickShow.pri)

win32:!mingw {
    RC_FILE = App.rc
}
macos {
    ICON = milk.icns
}

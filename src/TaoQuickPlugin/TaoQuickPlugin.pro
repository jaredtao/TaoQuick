QT  += core gui qml

#TARGET = $$qtLibraryTarget(TaoQuickPlugin)
TARGET = TaoQuickPlugin
TEMPLATE = lib
CONFIG += plugin
msvc {
    QMAKE_CFLAGS += -source-charset:utf-8
    QMAKE_CXXFLAGS += -source-charset:utf-8
}
load(taoVersion)

include(../TaoPlugin.pri)

load(taoBundle)
BundlePath = $$getBundlePath("TaoQuickApp")

load(taoBuildPath)
setBuildPath($${TaoQuick_BUILD_TREE}/$${TARGET})

CONFIG(debug, debug|release){
    DESTDIR=$${TaoQuick_RUN_TREE}/debug/$${BundlePath}TaoPlugin
} else {
    DESTDIR=$${TaoQuick_RUN_TREE}/release/$${BundlePath}TaoPlugin
}

SOURCES += \
        Src/TaoQuickPlugin.cpp

HEADERS += \
        Src/TaoQuickPlugin.h

RESOURCES += \
    Qml.qrc

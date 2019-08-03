QT  += core gui qml

TARGET = $$qtLibraryTarget(TaoEffect)
TEMPLATE = lib
CONFIG += plugin
msvc {
    QMAKE_CFLAGS += -source-charset:utf-8
    QMAKE_CXXFLAGS += -source-charset:utf-8
}

include(../TaoQuickApp/PluginCommon.pri)

SOURCES += \
        Src/EffectsPlugin.cpp

HEADERS += \
        Src/EffectsPlugin.h

RESOURCES += \
    Qml.qrc
CONFIG(debug, debug|release){
    tgt=$$absolute_path($${_PRO_FILE_PWD_}/../../bin/debug/TaoPlugin)
} else {
    tgt=$$absolute_path($${_PRO_FILE_PWD_}/../../bin/release/TaoPlugin)
}
win32 {
    tgt ~= s,/,\\\\,g
}
DESTDIR = $${tgt}

OTHER_FILES += README.md \
    .clang-format \
    LICENSE

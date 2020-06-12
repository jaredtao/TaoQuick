QT  += core gui qml

#TARGET = $$qtLibraryTarget(TaoEffect)
TARGET = TaoEffect
TEMPLATE = lib
CONFIG += plugin
msvc {
    QMAKE_CFLAGS += -source-charset:utf-8
    QMAKE_CXXFLAGS += -source-charset:utf-8
}

include(../TaoPlugin.pri)
include(../TaoBundle.pri)

SOURCES += \
        Src/EffectsPlugin.cpp

HEADERS += \
        Src/EffectsPlugin.h

RESOURCES += \
    Qml.qrc
CONFIG(debug, debug|release){
    tgt=$$absolute_path($${_PRO_FILE_PWD_}/../../bin/debug/$${BundlePath}TaoPlugin)
} else {
    tgt=$$absolute_path($${_PRO_FILE_PWD_}/../../bin/release/$${BundlePath}TaoPlugin)
}
win32 {
    tgt ~= s,/,\\\\,g
}
DESTDIR = $${tgt}
CONFIG(debug,debug|release){
    MOC_DIR = build/debug/moc
    RCC_DIR = build/debug/rcc
    UI_DIR = build/debug/ui
    OBJECTS_DIR = build/debug/obj
} else {
    MOC_DIR = build/release/moc
    RCC_DIR = build/release/rcc
    UI_DIR = build/release/ui
    OBJECTS_DIR = build/release/obj
}

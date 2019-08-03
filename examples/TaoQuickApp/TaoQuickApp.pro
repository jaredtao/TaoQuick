TEMPLATE = app
TARGET = TaoQuickApp
QT += qml quick
CONFIG += plugin c++14 qtquickcompiler

include(../../common/TaoVersion.pri)
#msvc{
#    QMAKE_CFLAGS += -source-charset:utf-8
#    QMAKE_CXXFLAGS += -source-charset:utf-8
#}
#一部分头文件加入编译预处理，提高编译速度
CONFIG += precompile_header
PRECOMPILED_HEADER = Src/stdafx.h
precompile_header:!isEmpty(PRECOMPILED_HEADER) {
    DEFINES += USING_PCH
}

win32 {
    RC_FILE = App.rc
}
macos {
    ICON = milk.icns
}

CONFIG(debug,debug|release){
    DESTDIR = $$absolute_path($${_PRO_FILE_PWD_}/../../bin/debug/)
    MOC_DIR = build/debug/moc
    RCC_DIR = build/debug/rcc
    UI_DIR = build/debug/ui
    OBJECTS_DIR = build/debug/obj
} else {
    DESTDIR = $$absolute_path($${_PRO_FILE_PWD_}/../../bin/release/)
    MOC_DIR = build/release/moc
    RCC_DIR = build/release/rcc
    UI_DIR = build/release/ui
    OBJECTS_DIR = build/release/obj
}

HEADERS += \
    Src/ITaoQuickPlugin.h \
    Src/Logger/Logger.h \
    Src/Logger/LoggerTemplate.h \
    Src/TaoView.h \
    Ver.h
SOURCES += \
    Src/Logger/Logger.cpp \
    Src/TaoView.cpp \
    Src/main.cpp

RESOURCES += \
    Qml.qrc \
    Image.qrc

TRANSLATIONS += \
    trans/trans_zh.qs \
    trans/trans_en.qs \
    trans/trans_ja.qs \
    trans/trans_ko.qs \
    trans/trans_fr.qs \
    trans/trans_es.qs \
    trans/trans_pt.qs \
    trans/trans_it.qs \
    trans/trans_ru.qs \
    trans/trans_vi.qs \
    trans/trans_de.qs \
    trans/trans_ar.qs
#pretarget for copy qm
!equals(_PRO_FILE_PWD_, $$DESTDIR) {
    copy_qm.target = copyqm
    copy_qm.depends = $$_PRO_FILE_PWD_/Trans/*.qm
    srs = $$_PRO_FILE_PWD_/Trans/*.qm
    tgt = $$DESTDIR
    win32 {
        tgt ~= s,/,\\\\,g
        srs ~= s,/,\\\\,g
    }
    copy_qm.commands = $${QMAKE_COPY_FILE} $${srs} $${tgt}
}
macos{
    CONFIG(debug, debug|release){
        CONFIG -=app_bundle
        QMAKE_EXTRA_TARGETS += copy_qm
        PRE_TARGETDEPS += $$copy_qm.target
    } else {
        bundle_qm.files =$$files($$_PRO_FILE_PWD_/Trans/*.qm)
        bundle_qm.path= Contents/MacOS
        QMAKE_BUNDLE_DATA += bundle_qm
    }
} else {
    QMAKE_EXTRA_TARGETS += copy_qm
    PRE_TARGETDEPS += $$copy_qm.target
}



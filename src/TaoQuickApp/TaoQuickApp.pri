HEADERS += \
    $$PWD/Src/ITaoQuickPlugin.h \
    $$PWD/Src/Logger/Logger.h \
    $$PWD/Src/Logger/LoggerTemplate.h \
    $$PWD/Src/TaoView.h

win32:msvc {
    HEADERS += $$PWD/Ver.h
} else {
    HEADERS += $$PWD/Ver-u8.h
}
SOURCES += \
    $$PWD/Src/Logger/Logger.cpp \
    $$PWD/Src/TaoView.cpp \
    $$PWD/Src/main.cpp

RESOURCES += \
    $$PWD/Qml.qrc \
    $$PWD/Image.qrc

TRANSLATIONS += \
    $$PWD/trans/trans_zh.qs \
    $$PWD/trans/trans_en.qs \
    $$PWD/trans/trans_ja.qs \
    $$PWD/trans/trans_ko.qs \
    $$PWD/trans/trans_fr.qs \
    $$PWD/trans/trans_es.qs \
    $$PWD/trans/trans_pt.qs \
    $$PWD/trans/trans_it.qs \
    $$PWD/trans/trans_ru.qs \
    $$PWD/trans/trans_vi.qs \
    $$PWD/trans/trans_de.qs \
    $$PWD/trans/trans_ar.qs

#pretarget for copy qm
!equals(_PRO_FILE_PWD_, $$DESTDIR) {
    copy_qm.target = copyqm
    copy_qm.depends = $$PWD/Trans/*.qm
    srs = $$PWD//Trans/*.qm
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
        bundle_qm.files =$$files($$PWD/Trans/*.qm)
        bundle_qm.path= Contents/MacOS
        QMAKE_BUNDLE_DATA += bundle_qm
    }
} else {
    QMAKE_EXTRA_TARGETS += copy_qm
    PRE_TARGETDEPS += $$copy_qm.target
}



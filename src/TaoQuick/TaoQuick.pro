TEMPLATE = lib

TARGET = TaoQuick

QT += qml quick

CONFIG += plugin c++11 qtquickcompiler

versionAtLeast(QT_VERSION, 5.15.0) {
    # 5.15 use new feature: qmltypes,QML_IMPORT_NAME
    CONFIG += qmltypes
    QML_IMPORT_NAME = $$TARGET
    QML_IMPORT_MAJOR_VERSION = 1
}

uri = $$TARGET

include(../TaoVersion.pri)
include(../TaoBundle.pri)
include(TaoQuick.pri)
include(TaoQuick/TaoQuickDesigner.pri)

CONFIG(debug, debug|release){
    DESTDIR = $${TaoQuick_RUN_TREE}/debug/$${BundlePath}$${uri}
} else {
    DESTDIR = $${TaoQuick_RUN_TREE}/release/$${BundlePath}$${uri}
}
CONFIG(debug,debug|release){
    MOC_DIR = $${TaoQuick_BUILD_TREE}/$${TARGET}/debug/moc
    RCC_DIR = $${TaoQuick_BUILD_TREE}/$${TARGET}/debug/rcc
    UI_DIR = $${TaoQuick_BUILD_TREE}/$${TARGET}/debug/ui
    OBJECTS_DIR = $${TaoQuick_BUILD_TREE}/$${TARGET}/debug/obj
    QMLCACHE_DIR = $${TaoQuick_BUILD_TREE}/$${TARGET}/debug/qmlcache
} else {
    MOC_DIR = $${TaoQuick_BUILD_TREE}/$${TARGET}/release/moc
    RCC_DIR = $${TaoQuick_BUILD_TREE}/$${TARGET}/release/rcc
    UI_DIR = $${TaoQuick_BUILD_TREE}/$${TARGET}/release/ui
    OBJECTS_DIR = $${TaoQuick_BUILD_TREE}/$${TARGET}/release/obj
    QMLCACHE_DIR = $${TaoQuick_BUILD_TREE}/$${TARGET}/release/qmlcache
}

!android:!equals(_PRO_FILE_PWD_, $$DESTDIR) {
    copy_qmldir.target = $$DESTDIR/qmldir
    copy_qmldir.depends = $$_PRO_FILE_PWD_/qmldir
    win32 {
        copy_qmldir.target ~= s,/,\\\\,g
        copy_qmldir.depends ~= s,/,\\\\,g
    }
    copy_qmldir.commands = $${QMAKE_COPY_FILE} $${copy_qmldir.depends} $${copy_qmldir.target}
    QMAKE_EXTRA_TARGETS += copy_qmldir
    PRE_TARGETDEPS += $$copy_qmldir.target
}



installPath = $$[QT_INSTALL_QML]/$${uri}
win32 {
    installPath ~= s,/,\\,g
}
qmldir.files = qmldir
qmldir.path = $$installPath
!android:INSTALLS += qmldir

!android:target.path = $$installPath
INSTALLS += target


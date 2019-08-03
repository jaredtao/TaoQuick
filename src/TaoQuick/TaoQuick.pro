TEMPLATE = lib

TARGET = $$qtLibraryTarget(TaoQuick)

QT += qml quick
CONFIG += plugin c++11 qtquickcompiler
uri = TaoQuick

BundlePath=
macos{
    CONFIG(debug, debug|release){
          CONFIG -=app_bundle
    } else {
          BundlePath=TaoQuickDemo.app/Contents/MacOS/
    }
}

CONFIG(debug, debug|release){
    DESTDIR = $$absolute_path($${_PRO_FILE_PWD_}/../../bin/debug/$${BundlePath}$${uri})
} else {
    DESTDIR = $$absolute_path($${_PRO_FILE_PWD_}/../../bin/release/$${BundlePath}$${uri})
}

include(../../common/TaoVersion.pri)
include(Qml/TaoQuickDesigner.pri)
include(TaoQuick.pri)

build_pass:!equals(_PRO_FILE_PWD_, $$DESTDIR) {
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

DISTFILES = qmldir
qmldir.files = qmldir

installPath = $$[QT_INSTALL_QML]/$${uri}
win32 {
    installPath ~= s,/,\\,g
}
qmldir.path = $$installPath
target.path = $$installPath
INSTALLS += target qmldir


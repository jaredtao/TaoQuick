TEMPLATE = lib

TARGET = TaoQuick


versionAtLeast(QT_VERSION, 5.15.0) {
    # 5.15 use new feature: qmltypes,QML_IMPORT_NAME
    CONFIG += qmltypes
    QML_IMPORT_NAME = $$TARGET
    QML_IMPORT_MAJOR_VERSION = 1
}

uri = $$TARGET
load(taoVersion)
setTaoVersion()

load(taoBundle)
BundlePath = $$getBundlePath("TaoQuickApp")

load(taoBuildPath)
setBuildPath($${TaoQuick_BUILD_TREE}/$${TARGET})

CONFIG(debug, debug|release){
    DESTDIR = $${TaoQuick_RUN_TREE}/debug/$${BundlePath}$${uri}
} else {
    DESTDIR = $${TaoQuick_RUN_TREE}/release/$${BundlePath}$${uri}
}

include(TaoQuick.pri)
include(TaoQuick/designer.pri)


QT += qml quick

CONFIG += plugin c++11 qtquickcompiler

CONFIG += file_copies

HEADERS += \
        $$PWD/Src/taoquick_plugin.h

SOURCES +=

RESOURCES += \
    $$PWD/Qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML2_IMPORT_PATH += $$PWD/TaoQuick

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH += $$PWD/TaoQuick
!android {
    qmldirFile = $$PWD/qmldir

    #copy_qmldir for general run
    copy_qmldir.files = $${qmldirFile}
    copy_qmldir.path = $$DESTDIR
    COPIES += copy_qmldir

    #install_qmldir for install
    installPath = $$[QT_INSTALL_QML]/$${uri}

    install_qmldir.files = $${qmldirFile}
    install_qmldir.path = $${installPath}
    INSTALLS += install_qmldir
    target.path = $$installPath
    INSTALLS += target
}

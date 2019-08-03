HEADERS += \
        $$PWD/Src/taoquick_plugin.h

SOURCES += \
    $$PWD/Src/taoquick_plugin.cpp

RESOURCES += \
    $$PWD/Image.qrc \
    $$PWD/Qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML2_IMPORT_PATH += $$_PRO_FILE_PWD_/Qml

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH += $$_PRO_FILE_PWD_/Qml
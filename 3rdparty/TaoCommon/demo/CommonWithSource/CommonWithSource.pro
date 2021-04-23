QT += quick

CONFIG += c++11

SOURCES += \
        main.cpp

RESOURCES += qml.qrc

# example use TaoCommon from source code.

include($$PWD/../../src/TaoCommon/TaoCommon.pri)
target.path = $$[QT_INSTALL_EXAMPLES]/TaoCommon/CommonWithSource
INSTALLS += target

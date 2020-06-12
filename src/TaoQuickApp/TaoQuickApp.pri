msvc {
    HEADERS += $$PWD/Ver-u16.h
    DEFINES += VER_Utf16
} else {
    HEADERS += $$PWD/Ver-u8.h
}

HEADERS += \
    $$PWD/Src/ITaoQuickPlugin.h \
    $$PWD/Src/Logger/Logger.h \
    $$PWD/Src/Logger/LoggerTemplate.h \
    $$PWD/Src/TaoView.h \
    $$PWD/Src/Trans.h \
    $$PWD/Src/FileReadWrite.h


SOURCES += \
    $$PWD/Src/Logger/Logger.cpp \
    $$PWD/Src/TaoView.cpp \
    $$PWD/Src/Trans.cpp \
    $$PWD/Src/main.cpp

RESOURCES += \
    $$PWD/Qml.qrc \
    $$PWD/Image.qrc

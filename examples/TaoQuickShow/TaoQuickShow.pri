#一部分头文件加入编译预处理，提高编译速度
msvc | gcc | xcode {
    CONFIG += precompile_header
    PRECOMPILED_HEADER = $$PWD/Src/stdafx.h
}

HEADERS += \
    $$PWD/Src/TaoFrameLessView.h \
    $$PWD/Src/TaoObject.h \
    $$PWD/Src/TaoFramework.h \
    $$PWD/Src/Trans.h \
    $$PWD/Src/AppInfo.h \
    $$PWD/Src/ComponentsManager.h

SOURCES += \
    $$PWD/Src/TaoFrameLessView.cpp \
    $$PWD/Src/TaoFramework.cpp \
    $$PWD/Src/Trans.cpp \
    $$PWD/Src/AppInfo.cpp \
    $$PWD/Src/ComponentsManager.cpp \
    $$PWD/Src/main.cpp

CONFIG(debug, debug|release) {
    #debug模式直接用本地qml文件,不要qrc资源文件。这样调试快一些。
    DEFINES += qmlPath=\\\"file:///$$PWD/Qml/\\\"
    DEFINES += contentsPath=\\\"file:///$$PWD/Contents/\\\"
    DEFINES += imgPath=\\\"file:///$$PWD/Image/\\\"
} else {
    #release模式用qrc、走资源文件。这样发布不会携带源码。
    RESOURCES += \
        $$PWD/Qml.qrc \
        $$PWD/Image.qrc \
        $$PWD/Contents.qrc

    DEFINES += qmlPath=\\\"qrc:/Qml/\\\"
    DEFINES += contentsPath=\\\"qrc:/Contents/\\\"
    DEFINES += imgPath=\\\"qrc:/Image/\\\"
}

!android:!ios {

    CONFIG += file_copies

    trans.files = $$PWD/Trans/language_zh.json
    trans.path = $$DESTDIR/Trans
    COPIES += trans
}
OTHER_FILES += $$PWD/Trans/language_zh.json

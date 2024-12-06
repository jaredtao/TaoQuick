#一部分头文件加入编译预处理，提高编译速度
PRECOMPILED_HEADER = $$PWD/Src/stdafx.h

HEADERS += \
    $$PWD/Src/AppInfo.h \
    $$PWD/Src/DeviceAddTable/DeviceAddItem.h \
    $$PWD/Src/DeviceAddTable/DeviceAddModel.h \
    $$PWD/Src/SimpleFramelessView.h

SOURCES += \
    $$PWD/Src/AppInfo.cpp \
    $$PWD/Src/DeviceAddTable/DeviceAddItem.cpp \
    $$PWD/Src/DeviceAddTable/DeviceAddModel.cpp \
    $$PWD/Src/SimpleFramelessView.cpp \
    $$PWD/Src/main.cpp

CONFIG(debug, debug|release) {
    #debug模式直接用本地qml文件,不要qrc资源文件。这样调试快一些。
    win32{
        path=$$system("cd")
        path ~=s,\\\\,/,g
    } else {
        path=$$system("pwd")
    }
    DEFINES +=TaoQuickShowPath=\\\"file:///$${path}/\\\"

    OTHER_FILES += $$files($$path/Qml/*.qml, true)
    OTHER_FILES += $$files($$path/Contents/*.qml, true)

} else {
    #release模式用qrc、走资源文件。这样发布不会携带源码。
    RESOURCES += \
        $$PWD/Qml.qrc \
        $$PWD/Image.qrc \
        $$PWD/Contents.qrc
    DEFINES +=TaoQuickShowPath=\\\"qrc:/\\\"
}


#一部分头文件加入编译预处理，提高编译速度
PRECOMPILED_HEADER = $$PWD/Src/stdafx.h

HEADERS += \
    $$PWD/Src/AppInfo.h \
    $$PWD/Src/DeviceAddTable/DeviceAddItem.h \
    $$PWD/Src/DeviceAddTable/DeviceAddModel.h

SOURCES += \
    $$PWD/Src/AppInfo.cpp \
    $$PWD/Src/DeviceAddTable/DeviceAddItem.cpp \
    $$PWD/Src/DeviceAddTable/DeviceAddModel.cpp \
    $$PWD/Src/main.cpp

CONFIG(debug, debug|release) {
    #debug模式直接用本地qml文件,不要qrc资源文件。这样调试快一些。
    win32{
        path=$$system("cd")
        path ~=s,\\\\,/,g
    } else {
        path=$$system("pwd")
    }
    qmlPath = \"file:///$${path}/Qml/\"
    contentsPath = \"file:///$${path}/Contents/\"
    imgPath = \"file:///$${path}/Image/\"
    transDir=\"$${path}/Trans/\"
#    DEFINES += qmlPath=\\\"file:///$$PWD/Qml/\\\"
#    DEFINES += contentsPath=\\\"file:///$$PWD/Contents/\\\"
#    DEFINES += imgPath=\\\"file:///$$PWD/Image/\\\"
} else {
    #release模式用qrc、走资源文件。这样发布不会携带源码。
    RESOURCES += \
        $$PWD/Qml.qrc \
        $$PWD/Image.qrc \
        $$PWD/Contents.qrc

    qmlPath = \"qrc:/Qml/\"
    contentsPath = \"qrc:/Contents/\"
    imgPath = \"qrc:/Image/\"
    transDir= \":/Trans/\"
#    DEFINES += qmlPath=\\\"qrc:/Qml/\\\"
#    DEFINES += contentsPath=\\\"qrc:/Contents/\\\"
#    DEFINES += imgPath=\\\"qrc:/Image/\\\"
}

#!android:!ios {

#    CONFIG += file_copies

#    trans.files = $$PWD/Trans/language_zh.json
#    trans.path = $$DESTDIR/Trans
#    COPIES += trans
#}
#OTHER_FILES += $$PWD/Trans/language_zh.json

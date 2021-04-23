!build_TaoCommon_lib:{
    DEFINES +=TaoCommon_NO_LIB
}

INCLUDEPATH += $$PWD 

HEADERS += \
    $$PWD/Common/FileReadWrite.h \
    $$PWD/Common/JsonSerialize.h \
    $$PWD/Common/ObjectMap.h \
    $$PWD/Common/Package.h \
    $$PWD/Common/PropertyHelper.h \
    $$PWD/Common/Subject.h \
    $$PWD/Frameless/TaoFrameLessView.h \
    $$PWD/Logger/Logger.h \
    $$PWD/Logger/LoggerTemplate.h \
    $$PWD/QuickTool/QuickTool.h \
    $$PWD/TaoCommonGlobal.h \
    $$PWD/TaoModel/TaoListItemBase.h \
    $$PWD/TaoModel/TaoListModel.h \
    $$PWD/TaoModel/TaoListModelBase.hpp \
    $$PWD/Thread/ThreadCommon.h \
    $$PWD/Thread/ThreadPool.h \
    $$PWD/Thread/ThreadWorkerController.h \
    $$PWD/Trans/Trans.h

SOURCES += \
    $$PWD/Logger/Logger.cpp \
    $$PWD/QuickTool/QuickTool.cpp \
    $$PWD/TaoModel/TaoListItemBase.cpp \
    $$PWD/TaoModel/TaoListModel.cpp \
    $$PWD/Thread/ThreadPool.cpp \
    $$PWD/Trans/Trans.cpp

win32 {
    SOURCES += \
        $$PWD/Frameless/TaoFrameLessView_win.cpp
} else {
    SOURCES += \
        $$PWD/Frameless/TaoFrameLessView_unix.cpp
}

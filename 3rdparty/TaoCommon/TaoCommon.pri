!build_TaoCommon_lib:{
    DEFINES +=TaoCommon_NO_LIB
}

INCLUDEPATH += $$PWD \
    $$PWD/Common \
    $$PWD/Logger \
    $$PWD/Thread

HEADERS += \
    $$PWD/Common/FileReadWrite.h \
    $$PWD/Common/ObjectMap.h \
    $$PWD/QuickTool/QuickTool.h \
    $$PWD/Common/Subject.h \
    $$PWD/Common/Package.h \
    $$PWD/Frameless/TaoFrameLessView.h \
    $$PWD/Logger/LoggerTemplate.h \
    $$PWD/Logger/Logger.h \
    $$PWD/TaoModel/TaoListItemBase.h \
    $$PWD/TaoModel/TaoListModel.h \
    $$PWD/TaoModel/TaoListModelBase.hpp \
    $$PWD/Thread/ThreadCommon.h \
    $$PWD/Thread/ThreadPool.h \
    $$PWD/Thread/ThreadWorkerController.h \
    $$PWD/Trans/Trans.h \
    $$PWD/TaoCommonGlobal.h

SOURCES += \
    $$PWD/Frameless/TaoFrameLessView.cpp \
    $$PWD/Logger/Logger.cpp \
    $$PWD/QuickTool/QuickTool.cpp \
    $$PWD/TaoModel/TaoListItemBase.cpp \
    $$PWD/TaoModel/TaoListModel.cpp \
    $$PWD/Thread/ThreadPool.cpp \
    $$PWD/Trans/Trans.cpp


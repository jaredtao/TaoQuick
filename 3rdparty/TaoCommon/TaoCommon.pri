!build_TaoCommon_lib:{
    DEFINES +=TaoCommon_NO_LIB
}

INCLUDEPATH += $$PWD \
    $$PWD/Common \
    $$PWD/Logger \
    $$PWD/Thread

HEADERS += \
    $$PWD/Common/filereadwrite.h \
    $$PWD/Common/objectmap.h \
    $$PWD/Common/singleton.h \
    $$PWD/Common/subject.h \
    $$PWD/Logger/loggertemplate.h \
    $$PWD/Logger/logger.h \
    $$PWD/Thread/threadcommon.h \
    $$PWD/Thread/threadpool.h \
    $$PWD/Thread/threadworkercontroller.h \
    $$PWD/taocommonglobal.h

SOURCES += \
    $$PWD/Logger/logger.cpp \
    $$PWD/Thread/threadpool.cpp


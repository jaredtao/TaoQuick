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
    $$PWD/Common/subject.h \
    $$PWD/Common/package.h \
    $$PWD/Frameless/TaoFrameLessView.h \
    $$PWD/Logger/loggertemplate.h \
    $$PWD/Logger/logger.h \
    $$PWD/Thread/threadcommon.h \
    $$PWD/Thread/threadpool.h \
    $$PWD/Thread/threadworkercontroller.h \
    $$PWD/Trans/Trans.h \
    $$PWD/taocommonglobal.h

SOURCES += \
    $$PWD/Frameless/TaoFrameLessView.cpp \
    $$PWD/Logger/logger.cpp \
    $$PWD/Thread/threadpool.cpp \
    $$PWD/Trans/Trans.cpp


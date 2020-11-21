!build_TaoCommon_lib:{
    DEFINES +=TaoCommon_NO_LIB
}

INCLUDEPATH += $$PWD 

hFile = $$files($$PWD/*.h, true)
hppFile = $$files($$PWD/*.hpp, true)
cppFile = $$files($$PWD/*.cpp, true)
HEADERS += \
    $$hFile \
    $$hppFile


SOURCES += \
    $$cppFile


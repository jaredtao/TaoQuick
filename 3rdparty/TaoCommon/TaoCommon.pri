!build_TaoCommon_lib:{
    DEFINES +=TaoCommon_NO_LIB
}

INCLUDEPATH += $$PWD 

hFile = $$files($$PWD/*.h, true)
hppFile = $$files($$PWD/*.hpp, true)
cppFile = $$files($$PWD/*.cpp, true)
win32 {
    hFile -= $$files($$PWD/Frameless/Unix/*.h)
    hppFile -= $$files($$PWD/Frameless/Unix/*.hpp)
    cppFile -= $$files($$PWD/Frameless/Unix/*.cpp)
} else {
    hFile -= $$files($$PWD/Frameless/Win/*.h)
    hppFile -= $$files($$PWD/Frameless/Win/*.hpp)
    cppFile -= $$files($$PWD/Frameless/Win/*.cpp)
}
HEADERS += \
    $$hFile \
    $$hppFile


SOURCES += \
    $$cppFile


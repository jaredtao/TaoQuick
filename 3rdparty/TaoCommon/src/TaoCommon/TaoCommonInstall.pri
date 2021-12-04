headersTargetPath=$$[QT_INSTALL_HEADERS]/$$MODULE_INCNAME
message("QMAKE_INSTALL_DIR $$headersTargetPath")

gHeader.files=$$PWD/TaoCommonGlobal.h
gHeader.path=$$headersTargetPath

commonHeader.files=$$PWD/Common/*.h
commonHeader.path=$$headersTargetPath/Common

framelessHeader.files=$$PWD/Frameless/*.h
framelessHeader.path=$$headersTargetPath/Frameless

loggerHeader.files=$$PWD/Logger/*.h
loggerHeader.path=$$headersTargetPath/Logger

quickModelHeader.files=$$PWD/QuickModel/*.h
quickModelHeader.path=$$headersTargetPath/QuickModel

quickToolHeader.files=$$PWD/QuickTool/*.h
quickToolHeader.path=$$headersTargetPath/QuickTool

threadHeader.files=$$PWD/Thread/*.h
threadHeader.path=$$headersTargetPath/Thread

transHeader.files=$$PWD/Trans/*.h
transHeader.path=$$headersTargetPath/Trans


INSTALLS += \
    gHeader commonHeader framelessHeader loggerHeader quickModelHeader \
    quickToolHeader threadHeader transHeader

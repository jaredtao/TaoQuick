TARGET = TaoCommon

load(qt_module)

QT += core gui quick
QMAKE_TARGET_COMPANY = "jaredtao.github.io"
QMAKE_TARGET_COPYRIGHT = "Copyright (C) 2019-2022 JaredTao <jared2020@163.com>"
QMAKE_TARGET_PRODUCT = "TaoCommon"
QMAKE_TARGET_DESCRIPTION = "common use code for Qt."

CONFIG += build_TaoCommon_lib
DEFINES += TaoCommon_Library 

include(TaoCommon.pri)

include(TaoCommonInstall.pri)

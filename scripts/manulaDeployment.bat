@echo off
cd ..
call "D:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build\vcvars64.bat"
set VCINSTALLDIR="C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC"
set winSdkDir=%WindowsSdkDir%
set winSdkVer=%WindowsSdkVersion%
set vcToolsInstallDir=%VCToolsInstallDir%
set vcToolsRedistDir=%VCToolsRedistDir%
set msvcArch=x64
set QTDIR=D:\Qt\5.15.2\msvc2019_64
set PATH=%PATH%;%QTDIR%\bin
powershell.exe -NoProfile -ExecutionPolicy Bypass -File scripts\windows-publish.ps1 TaoQuickShow TaoQuickShow.exe

cd scripts
@echo off
set QTDIR=D:\Qt\Online\6.2.4\msvc2019_64
set PATH=%QTDIR%\bin;%PATH%
qsb -b --glsl "150,120,100 es" --hlsl 50 --msl 12 -o cusColorOverlay.frag.qsb cusColorOverlay.frag

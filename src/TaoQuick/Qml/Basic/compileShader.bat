@echo off
set QTDIR=C:\Qt\6.8.1\msvc2022_64
set PATH=%QTDIR%\bin;%PATH%
qsb -b --glsl "150,120,100 es" --hlsl 50 --msl 12 -o cusColorOverlay.frag.qsb cusColorOverlay.frag
timeout /t 5
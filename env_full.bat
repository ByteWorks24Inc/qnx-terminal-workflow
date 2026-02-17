@echo off

REM ===== Windows system paths first (so where, dir, etc work) =====
set PATH=C:\Windows\System32;C:\Windows;%PATH%

REM ===== QNX Base =====
set QNX_BASE=C:\Users\xx\qnx800
set QNX_HOST=%QNX_BASE%\host\win64\x86_64
set QNX_TARGET=%QNX_BASE%\target\qnx
set QNX_CONFIGURATION=C:\Users\xx\.qnx
set QNX_CONFIGURATION_EXCLUSIVE=%QNX_CONFIGURATION%

REM ===== Compiler include paths =====
set MAKEFLAGS=-I%QNX_TARGET%\usr\include

REM ===== Add QNX tools to PATH =====
set PATH=%QNX_HOST%\usr\bin;%QNX_BASE%\jre\bin;%QNX_BASE%\host\common\bin;%PATH%

REM ===== Temp dir =====
set TMPDIR=%TEMP%

echo.
echo QNX SDP 8 Environment Loaded
echo.

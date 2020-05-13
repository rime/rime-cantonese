REM Windows weasel + Cantonese schema installation script
REM Author 
REM   - tanxpyox <tanxpyox@gmail.com>

@echo off

REM Install weasel
*installer.exe /S

REM Set environment variable
SET RIMEDIR=%APPDATA%\rime\
SET VERSION=weasel-0.14.3

REM Checks of user directory
if not exist %RIMEDIR% mkdir %RIMEDIR%

REM Copies bundled schema files into user directory
xcopy /s  data\ %RIMEDIR%

REM Deploy
C:\Program Files (x86)\Rime\%VERSION%\WeaselDeployer.exe /deploy

@echo off
REM Install weasel

echo Installing Weasel Frontend...
FOR /f "tokens=*" %%G IN ('dir /b *installer.exe') DO /S %%G 

REM Set environment variable
SET RIMEDIR=%APPDATA%\rime\
SET VERSION=weasel-0.14.3

REM Checks of user directory
if not exist %RIMEDIR% mkdir %RIMEDIR%

echo Copying Files...
REM Copies bundled schema files into user directory
xcopy /E /Y data %RIMEDIR%

REM Deploy

echo Deploying...
"C:\Program Files (x86)\Rime\%VERSION%\WeaselDeployer.exe" /Deploy

echo Script ends...
pause

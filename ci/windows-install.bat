@echo off
REM Install weasel

echo Checking for system architecture
reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set OS=32BIT || set OS=64BIT

echo Preparing installation environment
SET RIMEDIR=%APPDATA%\rime\
SET VERSION=weasel-0.14.3
SET RIMEPROGRAM=%ProgramFiles(x86)%\Rime\%VERSION%\
IF %OS%==32BIT SET RIMEPROGRAM=%ProgramFiles%\Rime\%VERSION%\

echo Installing Weasel Frontend...
for %%x in (*.exe) do (%%x /t)

REM Checks of user directory
if not exist %RIMEDIR% mkdir %RIMEDIR%

echo Copying Files...
REM Copies bundled schema files into user directory
xcopy /E /Y data %RIMEDIR%

REM Deploy

echo Deploying...
"%RIMEPROGRAM%\WeaselDeployer.exe" /deploy

echo Script ends...
pause

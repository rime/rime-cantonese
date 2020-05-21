@echo off

echo Checking system architecture...
reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set OS=32BIT || set OS=64BIT

echo Preparing installation environment...
SET RIMEDIR=%APPDATA%\rime\
SET VERSION=weasel-0.14.3
SET RIMEPROGRAM=%ProgramFiles(x86)%\Rime\%VERSION%\
IF %OS%==32BIT SET RIMEPROGRAM=%ProgramFiles%\Rime\%VERSION%\

echo Installing Weasel frontend...
for %%x in (*.exe) do (%%x /S)

SET /P TRADITIONAL=Configure Traditional Chinese (Y/[N])?
IF /I %TRADITIONAL% NEQ "N" "%RIMEPROGRAM%\WeaselSetup.exe" /T

REM Checks of user directory
if not exist %RIMEDIR% mkdir %RIMEDIR%

echo Copying IME files...
REM Copies bundled schema files into user directory
xcopy /E /Y data %RIMEDIR%

REM Deploy

echo Deploying...
"%RIMEPROGRAM%\WeaselDeployer.exe" /deploy

echo Done!
pause

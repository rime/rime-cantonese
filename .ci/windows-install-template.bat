@echo off

echo Checking system architecture...
reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set OS=32BIT || set OS=64BIT

echo Preparing installation environment...
SET RIMEDIR=%APPDATA%\rime\
SET VERSION=weasel-${WEASEL_VERSION}
SET RIMEPROGRAM=%ProgramFiles%\Rime\%VERSION%\
IF %OS%==64BIT SET RIMEPROGRAM=%ProgramFiles(x86)%\Rime\%VERSION%\

CHOICE /T 40 /C yn /D y /M "Configure Traditional Chinese"
echo Installing Weasel frontend...
IF ERRORLEVEL 2 (
  for %%x in (*.exe) do (%%x /S)
) else (
  for %%x in (*.exe) do (%%x /S /T)
)

if not exist %RIMEDIR% mkdir %RIMEDIR%

echo Copying IME files to %RIMEDIR%
xcopy /E /Y data %RIMEDIR%

echo Deploying... This may take quite a while...
"%RIMEPROGRAM%\WeaselDeployer.exe" /deploy

echo Done! Please restart your computer to complete the installation.
pause

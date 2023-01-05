@ECHO OFF

:: search for FW file
for /d %%I in (%~dp0.pio\build\*) do set "BuildFolder=%%I"
SET "FwFilePath=%BuildFolder%\firmware.bin"
IF NOT EXIST "%FwFilePath%" GOTO:ERROR_NO_FW_FILE

:: copy to SD card
FOR /F "tokens=2 usebackq delims==" %%I IN (`wmic volume where "DriveType=2" get DriveLetter /format:list`) DO set SdCardDriveLetter=%%I
IF EXIST "%SdCardDriveLetter%\firmware.bin" DEL "%SdCardDriveLetter%\firmware.bin"
IF EXIST "%SdCardDriveLetter%\firmware.cur" DEL "%SdCardDriveLetter%\firmware.cur"
COPY "%FwFilePath%" "%SdCardDriveLetter%\"

GOTO:EOF
:ERROR_NO_FW_FILE
ECHO.
ECHO   ERROR
ECHO.
ECHO  Firmware file could not be found
pause > nul
GOTO:EOF
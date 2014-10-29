@echo off
for /F "tokens=2" %%a in ('echo:^|time') do set fname=%%a
set fname=%fname::=%
set fname=%fname:~0.6%
echo Œ»İ‚Ì“ú %DATE% %TIME%

set YMD=%date:~-10,4%%date:~-5,2%%date:~-2,2%
set TIME2=%time: =0%
set HMS=%TIME2:~0,2%%TIME2:~3,2%%TIME2:~6,2%
echo Œ»İ‚Ì“ú %YMD% %HMS%

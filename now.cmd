@echo off
for /F "tokens=2" %%a in ('echo:^|time') do set fname=%%a
set fname=%fname::=%
set fname=%fname:~0.6%
echo 現在の日時 %DATE% %TIME%

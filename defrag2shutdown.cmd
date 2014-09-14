@echo off
set LogPath=C:\Users\Indou\Documents\%~n0.log

defrag c: /H /U /V /X > %LogPath% 2>&1

shutdown /s /t 10 /c "defrag and shutdown"

:@powershell -NoProfile -ExecutionPolicy RemoteSigned -Command "Start-Process powershell.exe -Verb runas" > c:\users\indou\add-route.bat.log 2>&1

:@powershell -NoProfile -ExecutionPolicy RemoteSigned -Command "Start-Process powershell.exe -File 'C:\Users\indou\Documents\GitHub\ps\add-route.ps1'" > c:\users\indou\add-route.bat.log 2>&1

:powershell.exe -NoProfile -File "C:\Users\indou\Documents\GitHub\ps\add-route.ps1" > c:\users\indou\add-route.bat.log 2>&1

powershell.exe -NoProfile -File "C:\Users\indou\Documents\GitHub\ps\route-11.ps1" "10" > c:\users\indou\add-route.bat.log 2>&1
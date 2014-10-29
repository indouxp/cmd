@echo off
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: 指定PORTのプロセス名を表示する。
:: ex)
:: > %0 49165
:: > %0 61100
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set DIR=%~dp0
set FILE=%~nx0
set NAME=%~n0
set NETSTAT=%DIR%%NAME%.netstat.txt
set FINDSTR=%DIR%%NAME%.findstr.txt
set TASKLIST=%DIR%%NAME%.tasklist.bat

set YMD=%date:~-10,4%%date:~-5,2%%date:~-2,2%
set TIME2=%time: =0%
set HMS=%TIME2:~0,2%%TIME2:~3,2%%TIME2:~6,2%

set PORT=%1
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: netstatの実行
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo:
netstat -aon > %NETSTAT%
if %errorlevel% neq 0 (echo netstat fail. & goto ERROR)

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: 指定PORTの抽出
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
findstr /r ":%PORT%" %NETSTAT% > %FINDSTR%
if %errorlevel% neq 0 (echo findstr %PORT% fail. &  goto ERROR)
echo netstat -aon ^| findstr /r ":%PORT%"
echo アクティブな接続
echo   プロトコル  ローカル アドレス          外部アドレス        状態           PID
type %FINDSTR%

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: tasklistコマンドの作成
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo @echo off > %TASKLIST%
if %errorlevel% neq 0 (echo %TASKLIST% fail. &  goto ERROR)
:usebackqは、パス名に空白を含む場合の対応
:: i:プロトコル j:ローカルアドレス k:外部アドレス l:状態 m:PID
for /F "tokens=1,2,3,4,5 usebackq" %%i in (%FINDSTR%) do (
  echo tasklist /FO TABLE /FI "PID eq %%m" >> %TASKLIST%
)

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: tasklistコマンドの実行
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo:
findstr "tasklist" %TASKLIST%
%comspec% /c %TASKLIST%
if %errorlevel% neq 0 (echo %TASKLIST% fail. & goto ERROR)

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: 終了
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:del %NETSTAT%
:del %FINDSTR%
:del %TASKLIST%

echo:
echo %FILE% create %NETSTAT%.
echo %FILE% create %FINDSTR%.
echo %FILE% create %TASKLIST%.
echo:
goto NORMAL

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: エラー終了
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:ERROR
echo %YMD%-%HMS%:%FILE% fail.
exit /b 1

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: 正常終了
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:NORMAL
echo %YMD%-%HMS%:%FILE% done.
exit /b 0


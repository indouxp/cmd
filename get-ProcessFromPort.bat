@echo off
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: �w��PORT�̃v���Z�X����\������B
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
:: netstat�̎��s
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo:
netstat -aon > %NETSTAT%
if %errorlevel% neq 0 (echo netstat fail. & goto ERROR)

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: �w��PORT�̒��o
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
findstr /r ":%PORT%" %NETSTAT% > %FINDSTR%
if %errorlevel% neq 0 (echo findstr %PORT% fail. &  goto ERROR)
echo netstat -aon ^| findstr /r ":%PORT%"
echo �A�N�e�B�u�Ȑڑ�
echo   �v���g�R��  ���[�J�� �A�h���X          �O���A�h���X        ���           PID
type %FINDSTR%

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: tasklist�R�}���h�̍쐬
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo @echo off > %TASKLIST%
if %errorlevel% neq 0 (echo %TASKLIST% fail. &  goto ERROR)
:usebackq�́A�p�X���ɋ󔒂��܂ޏꍇ�̑Ή�
:: i:�v���g�R�� j:���[�J���A�h���X k:�O���A�h���X l:��� m:PID
for /F "tokens=1,2,3,4,5 usebackq" %%i in (%FINDSTR%) do (
  echo tasklist /FO TABLE /FI "PID eq %%m" >> %TASKLIST%
)

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: tasklist�R�}���h�̎��s
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo:
findstr "tasklist" %TASKLIST%
%comspec% /c %TASKLIST%
if %errorlevel% neq 0 (echo %TASKLIST% fail. & goto ERROR)

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: �I��
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
:: �G���[�I��
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:ERROR
echo %YMD%-%HMS%:%FILE% fail.
exit /b 1

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ����I��
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:NORMAL
echo %YMD%-%HMS%:%FILE% done.
exit /b 0


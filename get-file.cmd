:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@echo off
set cwd=%~dp0
set ftpScript=%cwd%\%~n0.ftp
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
type %0
type %ftpScript%
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
ftp -s:%ftpScript%
exit /b %errorlevel%

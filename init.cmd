@echo off

:------------------------------------------------------------------------------
:sethome_entry
:------------------------------------------------------------------------------
  hostname > init.tmp
:sethome_exit
del init.tmp
:------------------------------------------------------------------------------

:------------------------------------------------------------------------------
:doskey_entry
:------------------------------------------------------------------------------
  doskey cat=type $*
  doskey h=doskey /history
  doskey ls=dir/w $*
  doskey rm=del $*
  doskey vi=vim $*
  doskey view=vim -R $*
  doskey cd=cd /d $*
  doskey alias=:if "$1"==rV (doskey //macro) else
  doskey alias=if "$1"=="" (doskey /macros) else ^
  for /f "delims== tokens=1,*" %%i in ("$*") do^
    @if "%%j" neq "" (^
      doskey $*^
    ) else (^
      doskey /macros ^| findstr /b /c:"%%i="^
    )
  doskey unalias=doskey $*=
:doskey_exit
:------------------------------------------------------------------------------
set path="C:\Users\indou\Utils4dos";"E:\Users\indou\vim74-kaoriya-win64";%path%

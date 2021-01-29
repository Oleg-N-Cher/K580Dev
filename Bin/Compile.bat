@ECHO OFF
SET K580Dev=%XDev%\K580Dev
IF "%XDev%"=="" SET K580Dev=..

IF "%MainMod%"=="" SET MainMod=%1
IF "%Pause%"=="" SET Pause=FALSE

SET Options=%Options% +rk86 -O3
SET Include=%Include% -I%K580Dev%\Lib\C -I%K580Dev%\Lib\Obj
IF "%Clean%"=="" SET Clean=TRUE

SET CC=zcc.exe %Options%

IF EXIST %1 GOTO Config

IF EXIST ..\C\%1.c DEL %1.oh %1.c
IF EXIST ..\C\%1.c %CC% -c ..\C\%1.c -I. -I..\Lib -I%K580Dev%\Lib %Include%
IF NOT EXIST ..\C\%1.c %CC% -c %1.c -I. -I..\Lib -I%K580Dev%\Lib %Include%
GOTO Exit

:Config

IF EXIST ..\C\%1.c DEL %1.oh %1.c
IF EXIST ..\C\%1.c %CC% -c ..\C\%1.c -I%1 %Include%
IF NOT EXIST ..\C\%1.c %CC% -c %1.c -I%1 %Include%

:Exit

IF errorlevel 1 PAUSE

IF NOT "%Clean%"=="TRUE" GOTO Done
IF "%1"=="%MainMod%" DEL %1.o
IF NOT "%1"=="%MainMod%" DEL %1.c

:Done

IF "%Pause%"=="TRUE" PAUSE

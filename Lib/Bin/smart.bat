@ECHO OFF
REM args:
REM   LibName ModName [PartName] [-noinit] [-nocut]

SET CC=zcc.exe +rk86 -O3 -vn -x -I. -I.. -I..\C
SET smartlib=..\..\..\Bin\smartlib
IF EXIST ..\C\%2.c GOTO c_lib

:o_lib

%smartlib% %2.c %3 %4 %5
GOTO compile

:c_lib

IF EXIST ..\C\%2.oh DEL %2.oh
IF EXIST ..\C\%2.c DEL %2.c
%smartlib% ..\C\%2.c %3 %4 %5

:compile

DIR /B %2_???.c > %2.lst

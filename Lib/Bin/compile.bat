@ECHO OFF
IF NOT "%ZCCCFG%"=="" GOTO z88dk
ECHO Please install z88dk and set up the system variable ZCCCFG
PAUSE
EXIT

:z88dk

SET CC=zcc.exe +pmd85 -m8080 -vn -x -I. -I.. -I..\C
SET SmartLib=..\..\..\Bin\smartlib.exe
IF EXIST ..\C\%1.c GOTO c_lib

:o_lib_obj

%CC% -c %1.c
IF NOT errorlevel 1 GOTO exit
%SmartLib% %1.c -nocut -noinit
%CC% -c %1.c
GOTO exit

:c_lib

IF EXIST ..\C\%1.oh DEL %1.oh
%CC% -c ..\C\%1.c

:exit
IF errorlevel 1 PAUSE

@ECHO OFF
IF NOT "%ZCCCFG%"=="" GOTO z88dk
ECHO Please install z88dk and set up the system variable ZCCCFG
PAUSE
EXIT

:z88dk

SET MainMod=%1
SET Opt=-SO3 --opt-code-size --max-allocs-per-node200000
::SET CC=zcc.exe +zx -vn -x -clib=sdcc_iy %Opt% -Cs"--disable-warning 85" -Cs"--disable-warning 59"
SET CC=zcc.exe +pmd85 -m8080 -vn -x
SET smartlib=..\..\..\Bin\smartlib.exe

CD ..\Obj
IF EXIST %MainMod%.oh DEL %MainMod%.oh
IF EXIST %MainMod%.c DEL %MainMod%.c

%smartlib% ..\C\%MainMod%.c
DIR /B %MainMod%_???.c > %MainMod%.lst

%CC% @%MainMod%.lst -o ..\%MainMod%.lib
IF errorlevel 1 PAUSE

DEL /Q %MainMod%.lst
..\Bin\clear

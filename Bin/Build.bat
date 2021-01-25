@ECHO OFF
IF NOT "%ZCCCFG%"=="" GOTO z88dk
ECHO Please install z88dk and set up the system variable ZCCCFG
PAUSE
EXIT

:z88dk

CD ..\Obj

SET MainMod=%1
SET Include=-I..\Lib -I..\Lib\C
SET Libraries=%Libraries% -L..\Lib -lRK86

zcc +pmd85 -m8080 %Include% %Libraries% %MainMod%.c -o %MainMod%.bin
IF errorlevel 1 PAUSE

..\Bin\bin2rk %MainMod%.bin >NUL
MOVE %MainMod%.rk ..\%MainMod%.rka >NUL

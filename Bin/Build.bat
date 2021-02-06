@ECHO OFF
SET K580Dev=%XDev%\K580Dev
IF "%XDev%"=="" SET K580Dev=..

IF "%MainMod%"=="" SET MainMod=%1
IF "%MainMod%"=="%1" GOTO Build

:Compile

SET SaveOptions=%Options%
SET SaveInclude=%Include%
CALL %K580Dev%\Bin\Compile.bat %1
SET Options=%SaveOptions%
SET Include=%SaveInclude%

:Build

SET Options=%Options% +rk86 -O3
SET Include=%Include% -I%K580Dev%\Lib\C -I%K580Dev%\Lib\Obj
SET Libraries=%Libraries% -L%K580Dev%\Lib -lRK86 -lXDev
IF "%Clean%"=="" SET Clean=TRUE
IF "%Start%"=="" SET Start=TRUE
IF "%Pause%"=="" SET Pause=FALSE
IF "%FileExt%"=="" SET FileExt=rk

SET CC=zcc.exe %Options% %Modules% %Libraries%

IF EXIST %MainMod% GOTO Config

%CC% %MainMod%.c -o %MainMod%.bin -I. -I..\Lib -I%K580Dev%\Lib %Include%
GOTO Link

:Config

%CC% %MainMod%.c -o %MainMod%.bin -I%MainMod% %Include%

:Link

IF errorlevel 1 PAUSE

%K580Dev%\Bin\bin2rk.exe %MainMod%.bin >NUL
MOVE %MainMod%.rk ..\%MainMod%.%FileExt% >NUL

IF NOT "%Clean%"=="TRUE" GOTO Done
DEL *.bin %MainMod%.oh %MainMod%.o
IF "%Modules%"=="" DEL %MainMod%.c

:Done

IF "%Pause%"=="TRUE" PAUSE
IF "%Start%"=="TRUE" START ..\%MainMod%.%FileExt%

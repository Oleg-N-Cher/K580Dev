@REM Build the library XDev
@REM ======================

@CD ..\Obj
@SET Lib=..\XDev.lib
@IF EXIST %Lib% DEL %Lib%
@CALL ..\Bin\smart %Lib% SYSTEM
@CALL ..\Bin\smart %Lib% CmdLine
@CALL ..\Bin\smart %Lib% Timer
@%CC% @SYSTEM.lst @CmdLine.lst @Timer.lst -o%Lib%
@..\Bin\clear

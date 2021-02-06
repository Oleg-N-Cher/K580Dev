@REM Build the library XDev
@REM ======================

@SET Lib=..\XDev.lib
@IF EXIST %Lib% DEL %Lib%
@CALL ..\Bin\smart %Lib% SYSTEM
@CALL ..\Bin\smart %Lib% CmdLine
@%CC% @SYSTEM.lst @CmdLine.lst -o%Lib%
@..\Bin\clear

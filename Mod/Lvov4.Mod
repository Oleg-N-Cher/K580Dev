MODULE Lvov4; (*$MAIN*)
IMPORT Lvov, SYSTEM, t := Timer;

VAR X, Y: SYSTEM.BYTE; W: INT16;

PROCEDURE P1 (posX, posY, color: SYSTEM.BYTE);
BEGIN
  Lvov.FIL_BOX(posX, posY, posX+8, posY+8, color);
END P1;

BEGIN
  X:=0; W:=32000;
  LOOP
  IF W>1 THEN W:=W-50;END;
    REPEAT X:=X+1;P1(X*8,0,3);P1(((X-1)*8),0,0);t.DelayWord(W) UNTIL X>=24;
    REPEAT X:=X-1; P1(X*8,0,3);P1(((X+1)*8),0,0); t.DelayWord(W) UNTIL X<=0;
  END;
END Lvov4.

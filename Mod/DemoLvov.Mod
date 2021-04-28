MODULE DemoLvov; (*$MAIN*)
IMPORT Lvov;

BEGIN
  Lvov.CLS(255);
  Lvov.PSET(0, 32, 3);
  Lvov.PRESET(10, 33);
  Lvov.LINE(0, 0, 128, 128, 2);
  Lvov.LINE(0, 10, 128, 138, 1);
  Lvov.BOX(50, 50, 75, 75, 3);
  Lvov.FIL_BOX(150, 150, 75, 75, 3);
(*
  Lvov.COLOR(5, 0);
  Lvov.PAINT(130, 30, 2, 3);
*)
  LOOP END
END DemoLvov.

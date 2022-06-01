(*$MAIN*) MODULE TestTimer; IMPORT RK86, Timer;
BEGIN
  RK86.PUTSTR("HELLO WORLD!");
  Timer.DelayWord(50000);
  RK86.PUTSTR("HELLO WORLD!");
  Timer.DelayWord(50000);
  RK86.PUTSTR("HELLO WORLD!");
  Timer.DelayWord(50000);
  RK86.PUTSTR("HELLO WORLD!");
  Timer.DelayWord(50000);
  RK86.PUTSTR("HELLO WORLD!");
  Timer.DelayWord(50000);
  RK86.QUIT
END TestTimer.

MODULE DemoSprt; (*$MAIN*)
IMPORT SYSTEM;

(* https://www.old-games.ru/forum/threads/assembler-i8080-uroki-praktika-pk-01.50209/ *)

BEGIN (*@
  #asm
        XRA  A
        OUT  (0xC2), A
        STA  0xBE38
        CALL 0xEBBC
        LXI  H, 0x5010
        LXI  D, 63
        MVI  A, 8
CELL:   MVI  M, 255
        INX  H
        MVI  M, 255
        DAD  D
        DCR  A
        JNZ  CELL
        HLT
  #endasm
*)
END DemoSprt.

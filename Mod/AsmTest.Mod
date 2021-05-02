MODULE AsmTest; (*$MAIN*) IMPORT SYSTEM;

PROCEDURE Border (color: SYSTEM.BYTE);
BEGIN (*@
  #asm
        POP  DE
        POP  HL
        PUSH HL
        PUSH DE
        LD   A, L
        LD   (0xBE38), A  ; BORDER
        CALL 0xF836       ; CLS
  #endasm
*)
END Border;

BEGIN
  Border(25);
  LOOP END
END AsmTest.

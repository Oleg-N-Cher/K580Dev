// http://www.danbigras.ru/Orion/Program/SoftWare.html

void RK86_CURSOR (unsigned char x, unsigned char y) __naked __z88dk_callee {
  #asm
        POP  HL
        EX   (SP), HL
        JP   0F83CH
  #endasm
} //RK86_CURSOR

/*--------------------------------- Cut here ---------------------------------*/
unsigned char RK86_GETCHAR (void) __naked {
  #asm
        CALL 0F803H
        LD   L, A
        RET
  #endasm
} //RK86_GETCHAR

/*--------------------------------- Cut here ---------------------------------*/
unsigned char RK86_PRESSED (void) __naked {
  #asm
        CALL 0F812H
        AND  1
        LD   L, A
        RET
  #endasm
} //RK86_PRESSED

/*--------------------------------- Cut here ---------------------------------*/
void RK86_PUTCHAR (unsigned char ch) __naked __z88dk_fastcall {
  #asm
        LD   C, L
        JP   0F809H
  #endasm
} //RK86_PRCHAR

/*--------------------------------- Cut here ---------------------------------*/
void RK86_PUTHEX (unsigned char ch) __naked __z88dk_fastcall {
  #asm
        LD   A, L
        JP   0F815H
  #endasm
} //RK86_PUTHEX

/*--------------------------------- Cut here ---------------------------------*/
void RK86_PUTSTR (unsigned char *str) __naked __z88dk_fastcall {
  #asm
        JP   0F818H
  #endasm
} //RK86_PUTSTR

/*--------------------------------- Cut here ---------------------------------*/
void RK86_QUIT (void) __naked {
  #asm
        JP   0F875H
  #endasm
} //RK86_QUIT

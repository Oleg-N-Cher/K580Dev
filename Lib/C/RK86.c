// http://www.danbigras.ru/Orion/Program/SoftWare.html

void RK86_CURSOR (unsigned char x, unsigned char y) __naked __z88dk_callee {
  #asm
        LD   C, 1BH
        CALL 0F809H    ; 1BH =>
        LD   C, 59H
        CALL 0F809H    ; 59H =>
        POP  HL
        POP  DE
        EX   (SP), HL
        LD   A, E
        ADD  32
        LD   C, A
        CALL 0F809H    ; y + 32 =>
        LD   A, L
        ADD  32
        LD   C, A
        JP   0F809H    ; x + 32 =>
  #endasm
} //RK86_CURSOR

/*--------------------------------- Cut here ---------------------------------*/
unsigned char RK86_GETCHAR (void) __naked {
  #asm
        CALL 0F803H    ; ВВОД C СИМВОЛА С КЛАВИАТУРЫ
        LD   L, A
        RET
  #endasm
} //RK86_GETCHAR

/*--------------------------------- Cut here ---------------------------------*/
unsigned char RK86_GETKEY (void) __naked {
  #asm
        CALL 0F81BH    ; ВВОД КОДА НАЖАТОЙ КЛАВИШИ (INKEY)
        LD   L, A
        RET
  #endasm
} //RK86_GETKEY

/*--------------------------------- Cut here ---------------------------------*/
unsigned char RK86_PRESSED (void) __naked {
  #asm
        CALL 0F812H    ; ОПРОС СОСТОЯНИЯ КЛАВИАТУРЫ
        AND  1
        LD   L, A
        RET
  #endasm
} //RK86_PRESSED

/*--------------------------------- Cut here ---------------------------------*/
void RK86_PUTCHAR (unsigned char ch) __naked __z88dk_fastcall {
  #asm
        LD   C, L
        JP   0F809H    ; ВЫВОД СИМВОЛА НА ЭКРАН
  #endasm
} //RK86_PRCHAR

/*--------------------------------- Cut here ---------------------------------*/
void RK86_PUTHEX (unsigned char ch) __naked __z88dk_fastcall {
  #asm
        LD   A, L
        JP   0F815H    ; ВЫВОД БАЙТА НА ЭКРАН В НЕХ-КОДЕ
  #endasm
} //RK86_PUTHEX

/*--------------------------------- Cut here ---------------------------------*/
void RK86_PUTSTR (unsigned char *str) __naked __z88dk_fastcall {
  #asm
        JP   0F818H    ; ВЫВОД НА ЭКРАН СООБЩЕНИЯ
  #endasm
} //RK86_PUTSTR

/*--------------------------------- Cut here ---------------------------------*/
int RK86_RND16 (void) __naked {
/*
Inputs:
   (seed1) contains a 16-bit seed value
   (seed2) contains a NON-ZERO 16-bit seed value
Outputs:
   HL is the result
   BC is the result of the LCG, so not that great of quality
   DE is preserved
Destroys:
   AF
cycle: 4,294,901,760 (almost 4.3 billion)
160cc
26 bytes
https://zx-pk.ru/threads/32499-portirovanie-desolate-na-vektor-06ts/page3.html
*/
  #asm
PUBLIC _RK86_RND8
_RK86_RND8:
        LD   HL, (seed1)
        LD   B, H
        LD   C, L
        ADD  HL, HL
        ADD  HL, HL
        INC  L
        ADD  HL, BC
        LD   (seed1), HL
        LD   HL, (seed2)
        ADD  HL, HL
        SBC  A, A
        AND  0b00101101
        XOR  L
        LD   L, A
        LD   (seed2), HL
        ADD  HL, BC
        RET
seed1:  DW   12345
seed2:  DW   54321
  #endasm
} //RK86_RND16

/*--------------------------------- Cut here ---------------------------------*/
void RK86_WAIT (unsigned int time) __naked __z88dk_fastcall {
  #asm
        EX   DE, HL
        LD   HL, (ref1)
WAIT1:  LD   A, (HL)
        INC  HL
        LD   A, (HL)
        INC  HL
        DEC  DE
        LD   A, E
        OR   D
        JP   NZ, WAIT1
        LD   (ref1), HL
        RET
ref1:   DW   0
  #endasm
} //RK86_WAIT

/*--------------------------------- Cut here ---------------------------------*/
void RK86_QUIT (void) __naked {
  #asm
        JP   0F875H    ; ВЫХОД В МОНИТОР
  #endasm
} //RK86_QUIT

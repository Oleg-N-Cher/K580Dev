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
void RK86_QUIT (void) __naked {
  #asm
        JP   0F875H    ; ВЫХОД В МОНИТОР
  #endasm
} //RK86_QUIT

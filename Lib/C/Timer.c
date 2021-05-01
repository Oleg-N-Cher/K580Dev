void Timer_DelayByte (unsigned char b) __naked __z88dk_fastcall {
#asm
        DEC  L
        JP   NZ, _Timer_DelayByte
        RET
#endasm
} //Timer_DelayByte

/*--------------------------------- Cut here ---------------------------------*/
void Timer_DelayWord (unsigned int w) __naked __z88dk_fastcall {
#asm
        DEC  HL
        LD   A, L
        OR   H
        JP   NZ, _Timer_DelayWord
        RET
#endasm
} //Timer_DelayWord

*-----------------------------------------------------------
* Title      : practical_06
* Written by : Maryna Sobol
* Date       : 25/2/2026
* Description: practical_06
*-----------------------------------------------------------
        ORG     $1000

START:
        LEA     $4000, A7      ; Initialize A7 as stack pointer

        MOVE.B  #1, -(A7)      
        MOVE.B  #2, -(A7)      
        MOVE.B  #3, -(A7)      
        MOVE.B  #4, -(A7)      

        MOVE.B  (A7)+, D1      
        MOVE.B  (A7)+, D1      
        MOVE.B  (A7)+, D1      
        MOVE.B  (A7)+, D1      

        SIMHALT                

        END     START

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

*-----------------------------------------------------------
* Title      : practical_06
* Written by : Maryna Sobol
* Date       : 25/2/2026
* Description: practical_06
*-----------------------------------------------------------
        ORG     $1000

START:

        MOVE.W  #9, D0          ; Task 9 (clear screen)
        MOVE.L  #0, D1          ; Required parameter
        TRAP    #15

        LEA     MESSAGE, A1     ; Load address of string
        MOVE.W  #13, D0         ; Task 13 (print string)
        TRAP    #15

        MOVE.W  #4, D0          ; Task 4 (terminate program)
        TRAP    #15

MESSAGE: 
        DC.B    'Trap Task Test',0

        END     START
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

*-----------------------------------------------------------
* Title      : practical_06
* Written by : Maryna Sobol
* Date       : 25/2/2026
* Description: practical_06
*-----------------------------------------------------------
    ORG $1000

START:
    LEA $4000, SP

    MOVE.B #1, -(SP)
    MOVE.B #2, -(SP)
    MOVE.B #3, -(SP)
    MOVE.B #4, -(SP)

    MOVE.B (SP)+, D1
    MOVE.B (SP)+, D1
    MOVE.B (SP)+, D1
    MOVE.B (SP)+, D1

END:    BRA END 


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

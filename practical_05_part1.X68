*-----------------------------------------------------------
* Title      : PRACTICAL 05
* Written by : Maryna Sobol
* Date       : 09/02/2026
* Description: PRACTICAL 05
*-----------------------------------------------------------
    ORG    $1000

INITIALISE:
    MOVE.B   #3, D0
    MOVE.B   #0, D1

GAME_LOOP:
    CMP.B    #1, DO
    BNE      GAME_POINTS
    BEQ      GAME_OVER

GAME_POINTS:
    ADD.B      #10, D1
    SUB.B      #1, D0
    BRA     GAME_LOOP

GAME_OVER:

    SIMHALT             ; halt simulator




*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

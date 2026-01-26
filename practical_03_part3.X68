*-----------------------------------------------------------
* Title      : PRACTICAL 03
* Written by : Maryna Sobol
* Date       : 26.01.2026
* Description: PRACTICAL 03 PART 03
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program
    
    LEA HEALTH, A3
    SUB.B   #10, (A3)

    SIMHALT             ; halt simulator
HEALTH  dc.b    $64

    END    START        ; last line of source



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

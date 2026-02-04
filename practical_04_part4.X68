*-----------------------------------------------------------
* Title      : PRACTICAL 04
* Written by : Maryna Sobol
* Date       : 04/02/2026
* Description: PRACTICAL 04
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program
    MOVE.B  #100, $2001  ;FIRST PLAYER HEALTH
    LEA     $2001, A1
    
    
    MOVE.B  #100, $2004  ;BOSS HEALTH
    LEA     $2004, A2
    BRA     IS_STILL_ALIVE
    
HEALING_STATION:
    ADD.B  #30, $2001
    BRA     FIGHT_STATION
    
FIGHT_STATION:
    SUB.B   #20, $2004 ; PLAYER -20HP THE BOSS
    SUB.B   #30, $2001   ;BOSS -10HP OF PLAYER
     
IS_STILL_ALIVE:
    TST.B   $2004
    BLE     GAME_END
    BRA     HEALING_STATION
    
GAME_END:
    MOVE.B  #$00, (A1)
    
    SIMHALT             ; halt simulator

    END    START        ; last line of source



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

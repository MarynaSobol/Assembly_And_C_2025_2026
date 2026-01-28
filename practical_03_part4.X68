*-----------------------------------------------------------
* Title      : PRACTICAL 03
* Written by : Maryna Sobol
* Date       : 26.01.2026
* Description: PRACTICAL 03 PART 04
*-----------------------------------------------------------
        ORG     $1000
START:


        LEA     PLAYER_HEALTH,A1    ;Player Health
        MOVE.B  #13,D0              ; Print string
        TRAP    #15


        LEA     PLAYER_POINTS,A1    ;Player Points
        MOVE.B  #13,D0
        TRAP    #15


        LEA     PLAYER_POS,A1       ;Player Position
        MOVE.B  #13,D0
        TRAP    #15


        LEA     BOSS_HEALTH,A1      ;Boss Health
        MOVE.B  #13,D0
        TRAP    #15


        LEA     BOSS_POS,A1         ;Boss Position
        MOVE.B  #13,D0
        TRAP    #15

        SIMHALT


PLAYER_HEALTH:
        DC.B    'Player Health: 100% ($64)',0       ;Data Section

PLAYER_POINTS:
        DC.B    'Player Points: 1500',0

PLAYER_POS:
        DC.B    'Player Position: X=120 Y=200',0

BOSS_HEALTH:
        DC.B    'Boss Health: 200',0

BOSS_POS:
        DC.B    'Boss Position: X=400 Y=100',0

        END     START


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

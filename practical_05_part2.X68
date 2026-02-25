*-----------------------------------------------------------
* Title      : PRACTICAL 05
* Written by : Maryna Sobol
* Date       : 09/02/2026
* Description: PRACTICAL 05
*-----------------------------------------------------------

        ORG     $1000

START:
        LEA     PLAYER_POSITION, A1   ; A1 -> Player X,Y
        LEA     ENEMY_POSITION, A2    ; A2 -> Enemy X,Y

        ; Load X coordinates
        MOVE.B  (A1), D0              ; D0 = Player X
        MOVE.B  (A2), D1              ; D1 = Enemy X
        CMP.B   D1, D0
        BNE     NO_COLLISION          ; X not equal ? no collision

        ; Load Y coordinates
        MOVE.B  1(A1), D0             ; D0 = Player Y
        MOVE.B  1(A2), D1             ; D1 = Enemy Y
        CMP.B   D1, D0
        BNE     NO_COLLISION          ; Y not equal ? no collision

        ; If both X and Y match
        BRA     COLLISION

NO_COLLISION:
        BRA     GAME_OVER             ; Or continue game logic

COLLISION:
        ; Collision detected at same X,Y (e.g. 55,55)
        BRA     GAME_OVER

GAME_OVER:
        SIMHALT

PLAYER_POSITION: DC.B 55, 55
ENEMY_POSITION:  DC.B 55, 55

        END     START

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

*-----------------------------------------------------------
* Title      : PRACTICAL 04
* Written by : Maryna Sobol
* Date       : 04/02/2026
* Description: PRACTICAL 04
*-----------------------------------------------------------

        ORG     $1000

START:
*-----------------------------------------------------------
* INITIAL GAME DATA
*-----------------------------------------------------------

        MOVE.B  #$64, PLAYER_HP      ; Player Health = 100
        MOVE.B  #$32, BOSS_HP        ; Boss Health = 50
        MOVE.W  #$0000, PLAYER_X
        MOVE.W  #$0000, PLAYER_Y
        MOVE.W  #$000A, BOSS_X
        MOVE.W  #$000A, BOSS_Y
        MOVE.W  #$0000, PLAYER_PTS

        LEA     PLAYER_HP, A0        ; Player data pointer
        LEA     BOSS_HP, A1          ; Boss data pointer

        BRA     GAME_LOOP

*-----------------------------------------------------------
* GAME LOOP
*-----------------------------------------------------------
GAME_LOOP:
        BSR     PLAYER_ATTACK
        BSR     BOSS_ATTACK
        BSR     CHECK_STATUS
        BRA     GAME_LOOP

*-----------------------------------------------------------
* PLAYER ATTACK SUBROUTINE
*-----------------------------------------------------------
PLAYER_ATTACK:
        MOVE.B  (A1), D0             ; Load Boss HP
        SUB.B   #10, D0              ; Player deals 10 damage
        MOVE.B  D0, (A1)

        MOVE.W  PLAYER_PTS, D1
        ADD.W   #5, D1               ; Gain points
        MOVE.W  D1, PLAYER_PTS
        RTS

*-----------------------------------------------------------
* BOSS ATTACK SUBROUTINE
*-----------------------------------------------------------
BOSS_ATTACK:
        MOVE.B  (A0), D0             ; Load Player HP
        SUB.B   #8, D0               ; Boss deals 8 damage
        MOVE.B  D0, (A0)
        RTS

*-----------------------------------------------------------
* CHECK GAME STATUS
*-----------------------------------------------------------
CHECK_STATUS:
        MOVE.B  PLAYER_HP, D0
        TST.B   D0
        BLE     GAME_OVER

        MOVE.B  BOSS_HP, D1
        TST.B   D1
        BLE     GAME_OVER

* Logical operations example
        AND.B   #%11111110, D0       ; Mask example
        OR.B    #%00000001, D0
        EOR.B   #%00000001, D0

        RTS

*-----------------------------------------------------------
* GAME OVER
*-----------------------------------------------------------
GAME_OVER:
        MOVE.B  #$00, PLAYER_HP
        MOVE.B  #$00, BOSS_HP
        SIMHALT

*-----------------------------------------------------------
* DATA SECTION
*-----------------------------------------------------------
        ORG     $2000

PLAYER_HP:     DS.B 1
BOSS_HP:       DS.B 1
PLAYER_X:      DS.W 1
PLAYER_Y:      DS.W 1
BOSS_X:        DS.W 1
BOSS_Y:        DS.W 1
PLAYER_PTS:    DS.W 1

        END     START

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

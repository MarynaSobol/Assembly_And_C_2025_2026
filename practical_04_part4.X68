*-----------------------------------------------------------
* Title      : PRACTICAL 04
* Written by : Maryna Sobol
* Date       : 04/02/2026
* Description: 
*-----------------------------------------------------------

        ORG     $1000

START:


        MOVE.B  #$64, PLAYER_HP     ; Player Health = 100
        MOVE.B  #$32, BOSS_HP       ; Boss Health = 50
        MOVE.W  #10, PLAYER_X
        MOVE.W  #20, PLAYER_Y
        MOVE.W  #40, BOSS_X
        MOVE.W  #30, BOSS_Y
        MOVE.W  #0,  PLAYER_POINTS

        LEA     PLAYER_HP, A0       ; Address register usage
        LEA     BOSS_HP, A1

        BRA     GAME_LOOP

GAME_LOOP:
        BSR     PLAYER_ATTACK
        BSR     BOSS_ATTACK
        BSR     CHECK_HEALTH
        BRA     GAME_LOOP

PLAYER_ATTACK:
        MOVE.B  (A1), D0            ; Boss HP
        SUB.B   #10, D0             ; Damage boss
        MOVE.B  D0, (A1)

        MOVE.W  PLAYER_POINTS, D1
        ADD.W   #5, D1              ; Gain points
        MOVE.W  D1, PLAYER_POINTS
        RTS

BOSS_ATTACK:
        MOVE.B  (A0), D0            ; Player HP
        SUB.B   #8, D0              ; Damage player
        MOVE.B  D0, (A0)
        RTS


CHECK_HEALTH:
        MOVE.B  PLAYER_HP, D0
        TST.B   D0
        BLE     GAME_OVER

        MOVE.B  BOSS_HP, D1
        TST.B   D1
        BLE     GAME_OVER

* Logical operations (spec requirement)
        AND.B   #%11111110, D0
        OR.B    #%00000001, D0
        EOR.B   #%00000001, D0

        RTS


GAME_OVER:
        MOVE.B  #0, PLAYER_HP
        MOVE.B  #0, BOSS_HP
        SIMHALT


        ORG     $2000

PLAYER_HP:      DS.B 1
BOSS_HP:        DS.B 1
PLAYER_X:       DS.W 1
PLAYER_Y:       DS.W 1
BOSS_X:         DS.W 1
BOSS_Y:         DS.W 1
PLAYER_POINTS:  DS.W 1

        END     START

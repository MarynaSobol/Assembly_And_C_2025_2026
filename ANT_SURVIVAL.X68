*-----------------------------------------------------------
* Title      : PROJECT_1: ANT SURVIVAL: 7DAYS/ENDLESS
* Written by : MARYNA SOBOL C00312784
* Date       : 06.03.2026
* Description: 
*A tiny ant out each day to gather food for its hungry colony. 
*The world outside is full of dangers: storms and the occasional clumsy trip that could ruin a perfect haul.
*The ant must decide: forage for tasty morsels or take a nap to recover strength. 
*Too much greed, and it hurts itself; too little food, and the colony suffers.
*With courage, luck, and a bit of mischief, the ant strives to survive and keep its colony fed - one crumb at a time!

*-----------------------------------------------------------
    ORG    $1000             ; Start of program memory at $1000

*--- ARCHITECTURAL CONSTANTS

RESOURCES   EQU     $4000   ; Memory address for colony food/resources
GAME_MODE   EQU     $4002   ; Memory address to store chosen game mode
CUR_DAY     EQU     $4004   ; Memory address to store current day
ANT_HEALTH  EQU     $4006   ; Memory address to store ant's health points
RAND_SEED   EQU     $4008   ; Memory address to store random number seed
MAX_DAYS    EQU     7       ; Maximum number of days in 7-day mode

START:
    MOVE.B  #30,RESOURCES    ; Initialize colony resources to 30 units
    MOVE.B  #1,CUR_DAY       ; Set starting day to 1
    MOVE.B  #100,ANT_HEALTH  ; Set ant's health to 100 (max)
    BSR     INIT_RAND         ; Initialize random number generator
    BSR     WELCOME           ; Display welcome message
    BSR     CHOOSE_MODE       ; Ask player to select game mode
    BSR     GAMELOOP          ; Start main game loop
    SIMHALT                  ; Halt simulator after game ends

*--- UTILITIES

WELCOME:
    LEA     MSG_WELCOME,A1    ; Load address of welcome message into A1
    MOVE.B  #14,D0            ; Function 14 = print string in EASy68K TRAP #15
    TRAP    #15               ; Call OS/Simulator to display string
    RTS                        ; Return from subroutine

CHOOSE_MODE:
    LEA     MSG_MODE_MENU,A1  ; Load address of mode menu message
    MOVE.B  #14,D0            ; Function 14 = print string
    TRAP    #15               ; Display message
    MOVE.B  #4,D0             ; Function 4 = read 1-byte input from user
    TRAP    #15               ; Store input in D1
    MOVE.B  D1,GAME_MODE      ; Save selected mode in GAME_MODE
    RTS                        ; Return from subroutine

INIT_RAND:
    MOVE.B  #8,D0             ; Function 8 = initialize random generator
    TRAP    #15               ; Call TRAP #15
    MOVE.L  D1,RAND_SEED      ; Save initial random seed to memory
    RTS                        ; Return

GET_RAND:
    MOVE.L  RAND_SEED,D1      ; Load current seed into D1
    MULU    #25173,D1         ; Multiply by multiplier (linear congruential)
    ADD.L   #13849,D1         ; Add increment
    MOVE.L  D1,RAND_SEED      ; Store new seed
    AND.L   #$FFFF,D1         ; Limit to 16-bit number
    DIVU    #100,D1           ; Scale down to 0-99
    SWAP    D1                ; Swap upper and lower word to keep result in low word
    RTS                        ; Return random number in D1

ENDL:
    LEA     CRLF,A1           ; Load CRLF string for newline
    MOVE.B  #14,D0            ; Print string function
    TRAP    #15
    RTS

*--- MAIN GAME LOOP

    ORG     $2000            ; Start of main game code

GAMELOOP:
    BSR     HUD              ; Display current day, resources, and ant HP
    BSR     DECIDE_ACTION    ; Ask player to choose action (Forage or Rest)
    
    CMP.B   #2,D2            ; Check if player chose Rest (2)
    BEQ     SKIP_GATHER      ; If Rest, skip Forage and events
    
    BSR     FORAGE           ; Player chooses to forage for food
    BSR     EVENT_STORM      ; Random storm event may occur
    BSR     EVENT_TRIP       ; Player may trip and drop food
    BSR     QUEENS_FAVOR     ; Random chance queen gives extra resources
    BSR     PROCESS_HAUL     ; Process collected food and add to resources
    BRA     POST_ACTION      ; Jump to post-action logic

SKIP_GATHER:
    BSR     PERFORM_REST     ; Player chose to rest, recover HP

POST_ACTION:
    BSR     COLONY_EATS      ; Subtract food eaten by colony (-5 units)
    BSR     HEALTH_LOGIC     ; Update ant HP based on starvation/bonus
    BSR     FOOD_CHECK       ; Check if colony has run out of food
    BSR     DEATH_CHECK      ; Check if ant's health <= 0
    
    MOVE.B  GAME_MODE,D0
    CMP.B   #2,D0            ; If Endless mode, skip day limit check
    BEQ     NEXT_DAY
    
    MOVE.B  CUR_DAY,D0
    CMP.B   #MAX_DAYS,D0     ; In 7-day mode, check if max days reached
    BEQ     WIN_GAME         ; Player wins if survived MAX_DAYS

NEXT_DAY:
    ADDQ.B  #1,CUR_DAY       ; Increment day counter
    BSR     CONTINUE_PROMPT  ; Prompt user to continue to next day
    BRA     GAMELOOP         ; Repeat main game loop

*--- GAME LOGIC

DECIDE_ACTION:
    LEA     MSG_CHOOSE_ACT,A1 ; Load action prompt message
    MOVE.B  #14,D0            ; Print string
    TRAP    #15
    MOVE.B  #4,D0             ; Read 1-byte input
    TRAP    #15
    MOVE.B  D1,D2             ; Save player's choice in D2
    RTS

PERFORM_REST:
    LEA     MSG_RESTING,A1    ; Display resting message
    MOVE.B  #14,D0
    TRAP    #15
    ADD.B   #20,ANT_HEALTH    ; Recover 20 HP
    CMP.B   #100,ANT_HEALTH   ; Ensure HP does not exceed 100
    BLE     R_DN
    MOVE.B  #100,ANT_HEALTH
R_DN:
    CLR.L   D6                ; Clear haul amount (no food gathered)
    RTS

FORAGE:
    BSR     ENDL
    LEA     MSG_FORAGE_PROMPT,A1 ; Prompt for haul amount
    MOVE.B  #14,D0
    TRAP    #15
    MOVE.B  #4,D0             ; Read user input for haul
    TRAP    #15
    SUB.B   #5,ANT_HEALTH     ; Foraging costs 5 HP
    
    CMP.B   #15,D1            ; Check if user entered valid haul (<=15)
    BGT     OVERL             ; If exceeded, trigger greed penalty
    MOVE.B  D1,D6             ; Save haul amount in D6
    RTS

OVERL:
    LEA     MSG_HEAVY,A1      ; Display greed penalty message
    MOVE.B  #14,D0
    TRAP    #15
    SUB.B   #50,ANT_HEALTH    ; Penalty: lose 50 HP
    CLR.L   D6                ; No food collected
    RTS

EVENT_STORM:
    BSR     GET_RAND           ; Generate random number 0-99
    CMP.W   #20,D1             ; 20% chance of storm
    BGE     S_EX               ; If D1 >=20, skip storm
    LEA     MSG_RAIN,A1
    MOVE.B  #14,D0
    TRAP    #15
    SUB.B   #10,RESOURCES      ; Lose 10 food
    SUB.B   #20,ANT_HEALTH     ; Lose 20 HP
    CLR.L   D6                 ; Any haul is lost
S_EX:
    RTS

EVENT_TRIP:
    TST.B   D6                 ; Check if any haul collected
    BEQ     T_EX               ; If none, skip
    BSR     GET_RAND
    CMP.W   #15,D1             ; 15% chance to trip
    BGE     T_EX
    LEA     MSG_TRIP,A1
    MOVE.B  #14,D0
    TRAP    #15
    CLR.L   D6                 ; Drop all collected food
T_EX:
    RTS

QUEENS_FAVOR:
    BSR     GET_RAND             ; Random chance for queen to gift food
    CMP.W   #10,D1               ; 10% chance
    BGE     Q_EX
    LEA     MSG_QUEEN,A1
    MOVE.B  #14,D0
    TRAP    #15
    ADD.B   #8,RESOURCES         ; Gain +8 resources from queen
Q_EX:
    RTS

PROCESS_HAUL:
    TST.B   D6                    ; Check if any haul was collected
    BEQ     P_EMPTY               ; If none, skip success message

    LEA     MSG_SUCCESS,A1
    MOVE.B  #14,D0
    TRAP    #15
    MOVE.L  D6,D1                 ; Load haul amount into D1
    MOVE.B  #3,D0                 ; Function 3 = print byte as number
    TRAP    #15
    BSR     ENDL                  ; Print newline

    ADD.B   D6,RESOURCES          ; Add collected haul to resources
    RTS

P_EMPTY:
    LEA     MSG_LOST_ALL,A1
    MOVE.B  #14,D0
    TRAP    #15
    RTS

COLONY_EATS:
    SUB.B   #5,RESOURCES          ; Colony consumes 5 food units
    LEA     MSG_EAT,A1
    MOVE.B  #14,D0
    TRAP    #15
    RTS

HUD:
    BSR     ENDL                  ; Print blank line for clarity
    LEA     MSG_DAY,A1
    MOVE.B  #14,D0
    TRAP    #15
    CLR.L   D1
    MOVE.B  CUR_DAY,D1
    MOVE.B  #3,D0                 ; Function 3 = print byte as number
    TRAP    #15

    LEA     MSG_HUD_RES,A1
    MOVE.B  #14,D0
    TRAP    #15
    CLR.L   D1
    MOVE.B  RESOURCES,D1
    MOVE.B  #3,D0
    TRAP    #15

    LEA     MSG_HUD_HP,A1
    MOVE.B  #14,D0
    TRAP    #15
    CLR.L   D1
    MOVE.B  ANT_HEALTH,D1
    MOVE.B  #3,D0
    TRAP    #15

    BSR     ENDL                  ; Add blank line after HUD
    RTS

HEALTH_LOGIC:
    MOVE.B  RESOURCES,D0
    EXT.W   D0                     ; Convert to word for comparison
    CMP.W   #0,D0                  ; Check if resources = 0
    BLE     S_CRITICAL
    CMP.W   #10,D0                 ; Check if resources < 10
    BLT     S_MILD
    CMP.W   #30,D0                 ; Check if resources > 30
    BGT     S_GOOD
    RTS                             ; Otherwise no change to health

S_CRITICAL:
    LEA     MSG_STARVE_CRIT,A1
    SUB.B   #20,ANT_HEALTH         ; Severe starvation penalty
    BRA     H_MSG

S_MILD:
    LEA     MSG_STARVE_MILD,A1
    SUB.B   #20,ANT_HEALTH         ; Mild starvation penalty
    BRA     H_MSG

S_GOOD:
    LEA     MSG_PASSIVE_HEAL,A1
    ADD.B   #5,ANT_HEALTH          ; Bonus HP for sufficient food

H_MSG:
    MOVE.B  #14,D0
    TRAP    #15                     ; Display health message
    CMP.B   #100,ANT_HEALTH
    BLE     H_END
    MOVE.B  #100,ANT_HEALTH        ; Cap HP at 100
H_END:
    RTS

*--- LOSS CONDITIONS

FOOD_CHECK:
    MOVE.B  RESOURCES,D1        ; Load current resources
    EXT.W   D1                  ; Convert to word for comparison
    CMP.W   #0,D1               ; Check if resources are 0 or less
    BLE     GAME_OVER_FOOD      ; If 0 or less, trigger game over (starvation)
    RTS                         ; Otherwise, continue

DEATH_CHECK:
    MOVE.B  ANT_HEALTH,D1       ; Load ant's current HP
    EXT.W   D1                  ; Convert to word
    CMP.W   #0,D1               ; Check if HP <= 0
    BLE     GAME_OVER           ; If dead, end game
    RTS

GAME_OVER:
    LEA     MSG_DEAD,A1         ; Load death message
    MOVE.B  #14,D0
    TRAP    #15
    SIMHALT                     ; Stop simulation

GAME_OVER_FOOD:
    LEA     MSG_NO_FOOD,A1      ; Load colony starved message
    MOVE.B  #14,D0
    TRAP    #15
    SIMHALT                     ; Stop simulation

WIN_GAME:
    LEA     MSG_WIN,A1          ; Load victory message
    MOVE.B  #14,D0
    TRAP    #15
    SIMHALT                     ; Stop simulation

CONTINUE_PROMPT:
    LEA     MSG_NEXT,A1         ; Prompt user to continue to next day
    MOVE.B  #14,D0
    TRAP    #15
    MOVE.B  #4,D0               ; Read 1-byte input
    TRAP    #15
    RTS

*--- DATA SECTION

    ORG $4500                   ; Start of message/data memory

CRLF:            DC.B $0D,$0A,0 ; Carriage return + line feed

MSG_WELCOME:     DC.B '*******************************************',$0D,$0A
                 DC.B '* A N T   S U R V I V A L            *',$0D,$0A
                 DC.B '* 7-DAY / ENDLESS MODE               *',$0D,$0A
                 DC.B '*******************************************',$0D,$0A,0

MSG_WIN:         DC.B $0D,$0A
                 DC.B '   _________________________________   ',$0D,$0A
                 DC.B '  | [!] VICTORY: COLONY SURVIVED [!] | ',$0D,$0A
                 DC.B '  |__________________________________| ',$0D,$0A
                 DC.B '     The Queen is pleased with you.    ',$0D,$0A,0

MSG_DEAD:        DC.B $0D,$0A
                 DC.B '   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX   ',$0D,$0A
                 DC.B '   X        THE ANT HAS DIED       X   ',$0D,$0A
                 DC.B '   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX   ',$0D,$0A
                 DC.B '      Your journey ends in the dirt.   ',$0D,$0A,0

MSG_NO_FOOD:     DC.B $0D,$0A
                 DC.B '   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!  ',$0D,$0A
                 DC.B '   !     COLONY STARVED TO DEATH    !  ',$0D,$0A
                 DC.B '   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!  ',$0D,$0A
                 DC.B '     The hill has fallen silent...     ',$0D,$0A,0

MSG_MODE_MENU:   DC.B 'CHOOSE MODE: [1] 7-Day Survival [2] Endless: ',0
MSG_CHOOSE_ACT:  DC.B 'ACTION: [1] Forage [2] Rest: ',0
MSG_RESTING:     DC.B 'RECOVERY: +20 HP.',$0D,$0A,0
MSG_FORAGE_PROMPT: DC.B 'Enter haul amount (Max 15): ',0
MSG_HEAVY:       DC.B 'GREED PENALTY: Muscle tear! (-50 HP, 0 Food).',$0D,$0A,0
MSG_RAIN:        DC.B 'DISASTER: Storm! (-20 HP, -10 Food).',$0D,$0A,0
MSG_TRIP:        DC.B 'TRIP: You dropped the food!',$0D,$0A,0
MSG_SUCCESS:     DC.B 'SUCCESS: You brought back: ',0
MSG_LOST_ALL:    DC.B 'FAILURE: You returned empty handed.',$0D,$0A,0
MSG_QUEEN:       DC.B 'QUEEN FAVOR: Bonus food delivered!',$0D,$0A,0
MSG_EAT:         DC.B 'Colony eats 5 units.',$0D,$0A,0
MSG_STARVE_CRIT: DC.B 'STARVING: -20 HP.',$0D,$0A,0
MSG_STARVE_MILD: DC.B 'HUNGRY: -20 HP.',$0D,$0A,0
MSG_PASSIVE_HEAL: DC.B 'WELL FED: +5 HP stockpile bonus.',$0D,$0A,0
MSG_DAY:         DC.B '--- DAY ',0
MSG_HUD_RES:     DC.B ' | FOOD: ',0
MSG_HUD_HP:      DC.B ' | HP: ',0
MSG_NEXT:        DC.B 'Press 1 for next day: ',0

    END START                  ; End of program, entry point = START
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

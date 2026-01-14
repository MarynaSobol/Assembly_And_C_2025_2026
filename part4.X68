*-----------------------------------------------------------
* Title      : Practical 01 part 4
* Written by : Maryna Sobol
* Date       : 14.01.2026
* Description: Practical 01 part 4
*-----------------------------------------------------------
    MOVE.L #%00001111, D1   ; Load immediate into D1
    MOVE.B D1, D2           ; Copy byte from D1 to D2
    MOVE.B D1, $2000        ; Store byte from D1 to memory location $2000
    MOVE.B $2000, D2        ; Load byte from memory location $2000 into D2
    MOVE.B $2000, $3000     ; COPY BYTE FROM $2000 TO MEMORY LOCATION $3000
    ORG    $1000
START:                  ; first instruction of program
    MOVE.B #$64, D1     ; lOAD IMMEDIATE VALUE (100 IN DECIMAL) INTO D1
    LEA text, A1        ; LOAD ADDRESS OF TEXT INTO A1
    MOVE #14, D0        ; LOAD IMMEDIATE VALUE (14) INTO D0
    TRAP #15            ; EXECUTE TRAP (OUTPUT D0 TO CONSOLE)
    
    MOVE #3, D0         ; LOAD IMMEDIATE VALUE (3) INTO D0
    TRAP #15            ; EXECUTE TRAP (OUTPUTE D0 TO CONSOLE

    MOVE.B D4, D3           ; Copy byte from D4 to D3

* Put program code here

    SIMHALT             ; halt simulator
text:   dc.b 'Data Registor: ', 0   ; DEFINE THE STRING 'Data Registor: '
* Put variables and constants here

    END    START        ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~




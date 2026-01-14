*-----------------------------------------------------------
* Title      : Practical 01 part 2
* Written by : Maryna Sobol
* Date       : 14.01.2026
* Description: Practical 01 part 2
*-----------------------------------------------------------
    MOVE.L #%00001111, D1   ; Load immediate into D1
    MOVE.B D1, D2           ; Copy byte from D1 to D2
    MOVE.B D1, $2000        ; Store byte from D1 to memory location $2000
    MOVE.B $2000, D2        ; Load byte from memory location $2000 into D2
    MOVE.B $2000, $3000     ; COPY BYTE FROM $2000 TO MEMORY LOCATION $3000
    ORG    $1000
START:                  ; first instruction of program
    

* Put program code here

    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

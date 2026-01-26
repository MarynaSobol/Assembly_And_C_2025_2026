*-----------------------------------------------------------
* Title      : PRACTICAL 03
* Written by : Maryna Sobol
* Date       : 26.01.2026
* Description: PRACTICAL 03 PART 05
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program
    
    MOVEA.L #ACHIVEMENT_POINT, A1
    MOVE.L  #0, D0
    
    MOVE.L  (A1)+, D2
    ADD.L   D2, D0
    
    MOVE.L  (A1)+, D2
    ADD.L   D2, D0
    
    MOVE.L  (A1)+, D2
    ADD.L   D2, D0
    
    MOVE.L  (A1)+, D2
    ADD.L   D2, D0
    
    MOVE.L  (A1)+, D2
    ADD.L   D2, D0
    
ACHIVEMENT_POINT:  
    DC.L    5, 10, 15, 20, 30
    END    START


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

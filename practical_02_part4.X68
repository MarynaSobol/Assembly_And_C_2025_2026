*-----------------------------------------------------------
* Title      : Practical 02 part 4
* Written by : Maryna Sobol
* Date       : 19.01.2026
* Description: Practical 02 part 4
*-----------------------------------------------------------
	ORG	$1000
START:
	MOVE.L	#%100,	D0
	MOVE.L	#$100,	D0
	MOVE.L	#100,	D0

	MOVE.L	D0,	$3000
	MOVE.L	D1,	$3010
	MOVE.L	D2,	$3020

	MOVE.W	#100,	$3020
	MOVE.W	#100,	$3010
	MOVE.W	#100,	$3000

	MOVE.B	#100,	$3020
	MOVE.B	#$64,	$3010
	MOVE.B	#%10001111,	$3000


    	MOVE.L  #100, D0             	 ; DECIMAL LONG TO DATA REGISTERS
    	MOVE.L  #$64, D1             	 ; HEX LONG TO DATA REGISTERS
    	MOVE.L  #%1100100, D2        	 ; BINARY LONG TO DATA REGISTERS

    	MOVE.L  D0, D3              	 ; LONG COPY DATA REGISTER TO DATA REGISTER
    	MOVE.W  D1, D4              	 ; WORD COPY DATA REGISTER TO DATA REGISTER
    	MOVE.B  D2, D5               	 ; BYTE COPY DATA REGISTER TO DATA REGISTER

    	MOVE.L  D0, $3000            	 ; DATA REGISTER (LONG) TO MEMORY
    	MOVE.W  D1, $3004            	 ; DATA REGISTER (WORD) TO MEMORY
    	MOVE.B  D2, $3006            	 ; DATA REGISTER (BYTE) TO MEMORY

    	MOVE.B  #100, $3010          	 ; DECIMAL BYTE DIRECTLY TO MEMORY
    	MOVE.W  #$1234, $3012         	 ; HEX WORD DIRECTLY TO MEMORY
    	MOVE.L  #%1111000011110000, $3014 ; BINARY LONG DIRECTLY TO MEMORY

    	MOVE.B  $3010, D6            	 ; DATA OF MEMORY PLACE TO DATA REGISTERS (BYTE)
    	MOVE.W  $3012, D7            	 ; DATA OF MEMORY PLACE TO DATA REGISTERS (WORD)
    	MOVE.L  $3014, D0            	 ; DATA OF MEMORY PLACE TO DATA REGISTERS (LONG)

    	MOVE.B  #$7F, D1             	 ; HEX BYTE TO REGISTER
    	MOVE.W  #%1010101010101010, D2	 ; BINARY WORD TO REGISTER
    	MOVE.L  #$89ABCDEF, $3020     	 ; HEX LONG TO MEMORY

	SIMHALT

	END	START




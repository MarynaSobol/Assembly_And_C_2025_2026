*-----------------------------------------------------------
* Title      : Practical 02 part 2
* Written by : Maryna Sobol
* Date       : 19.01.2026
* Description: Practical 02 part 2
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

	SIMHALT

	END	START


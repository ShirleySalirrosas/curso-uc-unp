PROCESSOR 18F57Q84
    
    PSECT resetVect,class=CODE,reloc=2
    resetVect:
	goto Main 

#include "CONFIGURACION_DE_BITS.inc" ;// config statements should precede project file includes.
#include <xc.inc>

PSECT	udata_acs
offset:	DS  1
	
PSECT resetVect,class=CODE,reloc=2
resetVect:
    goto Main 

;PASOS PARA IMPLEMENTAR COMPUTE GOTO
; 1. Escribie el byte superior en PCLATU
; 2. Escribir el byte alto en PCLATH
; 3. Escribir el byte bajo en PCL
; NOTA: El offset debe ser multiplicado por 2 para el alineamiento en memoria 
    
PSECT CODE 
Main:
    MOVLW   0x03		;definimos el valor del offset
    MOVWF   offset,0
    BANKSEL PCLATU
    MOVLW   1ow highword(Table)
    MOVWF   PCLATU,1
    MOVLW   high(Table)
    MOVWF   PCLATH,1
    RLNCF   offset,0,0
;    MOVLW   0x02
;    MULWF   offset,0
;    MOVF    PRODL,w
    CALL    Table
    GOTO    Main
    
Table:
    ADDWF   PCL,1,0
    RETLW   00000000B	;offset: 0
    RETLW   11110000B	;offset: 1
    RETLW   00110011B	;offset: 2
    RETLW   00001111B	;offset: 3
    RETLW   11001100B	;offset: 4
    
END resetVect
PROCESSOR 18F57Q84
    
    PSECT resetVect,class=CODE,reloc=2
    resetVect:
	goto Main
	
#include "CONFIGURACION_DE_BITS" ;// config statements should precede project file includes.
#include <xc.inc>

;Zona de codigo
	
	ORG 0	;PROGRAMA COMIENZA EN LA POSICION 0
	
	INICIO:
	    BSF	    STATUS,RP0		;ACCESO AL BANCO1
	    CLRF    PORTB		;PUERTO B ESTA COMO SALIDAS
	    MOVLW   b'00011111'		;5 lineas se configuran
	    MOVWF   PORTA
	    BCF	    STATUS		;accseso a banco 0
	    
	PRINCIPAL:
	    MOVF    PORTA,W			;lee entradas
	    ANDLW   b'00001111'			;mascara para quedarse con valores 
	    CALL    Binario_a_7segmentos	;convierte datos binarios a 7segentos
	    MOVWF   PORTB
	    GOTO    PRINCIPAL
	    
	 
;--------------------------------SUBRITNA Binario_a_7segmentos"-----------------------
	    
	    Binario_a_7segmentos		    ;TABLA DEL DISPLAY 7 SEGMENTOS
	    
		    ADDWF   PCL,F
	    Tabla   retlw   3Fh		;codigo para el '0'
		    retlw   06h		;'1'
		    retlw   5Bh		;'2'
		    retlw   4Fh		;"3"
		    retlw   66h		;""4"
		    retlw   6Dh		;"5"
		    retlw   7Dh		;"6"
		    retlw   07h		;"7"
		    retlw   7Fh		;"8"
		    retlw   67h		;"9"
		    retlw   77h		;"A"
		    retlw   7Ch		;"B"
		    retlw   39h		;"C"
		    retlw   5Eh		;"D"
		    retlw   79h		;"E"
		    retlw   71h		;"F"
		
		    
END resetVect
		    



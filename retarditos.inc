PSECT udata_acs
    contador1: DS 1	;reserva 1 byte en acess ram
    contador2: DS 1

PSECT code
Delay_250ms:	    ;2Tcy -- call
    MOVLW   250		    ;1Tcy
    MOVWF   contador2,0	    ;1Tcy
   
    ;tiempo que consume = (6+4k) us    - 1Tcy = 1us
    Ext_Loop:		    
    MOVLW   249		    ;1Tcy - k1
    MOVWF   contador1,0	    ;1Tcy
    
    Int_Loop:
    NOP			    ;k1*Tcy
    DECFSZ  contador1,1,0   ;(k-1)+3
    GOTO    Int_Loop	    ;(k-1)*2
    DECFSZ  contador2,1,0
    GOTO    Ext_Loop
    RETURN		    ;2Tcy

    
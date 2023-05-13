
_initialize_Interrupt:

;MyProject.c,3 :: 		void initialize_Interrupt(void){
;MyProject.c,4 :: 		TMR0IE_bit=1; // Enable timer 0 interrupt
	BSF        TMR0IE_bit+0, BitPos(TMR0IE_bit+0)
;MyProject.c,5 :: 		GIE_bit=1; //Enable Global Interrupt
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
;MyProject.c,6 :: 		INTE_bit=1; //Enable ext interrupts
	BSF        INTE_bit+0, BitPos(INTE_bit+0)
;MyProject.c,7 :: 		T0CS_bit=0; // Select f/4 clock for the TMR0
	BCF        T0CS_bit+0, BitPos(T0CS_bit+0)
;MyProject.c,8 :: 		PSA_bit=0; // Prescaler is assigned to the Timer0 module
	BCF        PSA_bit+0, BitPos(PSA_bit+0)
;MyProject.c,9 :: 		PS0_bit=0; // Set pre-scaler to 8
	BCF        PS0_bit+0, BitPos(PS0_bit+0)
;MyProject.c,10 :: 		PS1_bit=1; // PS2,PS1,PS0 = 010
	BSF        PS1_bit+0, BitPos(PS1_bit+0)
;MyProject.c,11 :: 		PS2_bit=0; //
	BCF        PS2_bit+0, BitPos(PS2_bit+0)
;MyProject.c,12 :: 		TMR0=6; //counter starting value
	MOVLW      6
	MOVWF      TMR0+0
;MyProject.c,13 :: 		}
L_end_initialize_Interrupt:
	RETURN
; end of _initialize_Interrupt

_main:

;MyProject.c,14 :: 		void main() {
;MyProject.c,15 :: 		initialize_Interrupt(); // invoke interrupt initialization function
	CALL       _initialize_Interrupt+0
;MyProject.c,16 :: 		TRISD.B0=0; // This pin is set as output
	BCF        TRISD+0, 0
;MyProject.c,17 :: 		TRISD.B1=0; // This pin is set as output
	BCF        TRISD+0, 1
;MyProject.c,18 :: 		PORTD.B1=0; //this pin reset to 0
	BCF        PORTD+0, 1
;MyProject.c,19 :: 		while(1){
L_main0:
;MyProject.c,20 :: 		if(flag==0){
	MOVF       _flag+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main2
;MyProject.c,21 :: 		if(counter==500){ // check if the counter reaches 125
	MOVLW      0
	MOVWF      R0+0
	XORWF      _counter+3, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main11
	MOVF       R0+0, 0
	XORWF      _counter+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main11
	MOVLW      1
	XORWF      _counter+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main11
	MOVF       _counter+0, 0
	XORLW      244
L__main11:
	BTFSS      STATUS+0, 2
	GOTO       L_main3
;MyProject.c,22 :: 		counter=0; // start counter from the beginning
	CLRF       _counter+0
	CLRF       _counter+1
	CLRF       _counter+2
	CLRF       _counter+3
;MyProject.c,23 :: 		time=time++; // increase time one second
	MOVF       _time+0, 0
	MOVWF      R0+0
	MOVF       _time+1, 0
	MOVWF      R0+1
	MOVF       _time+2, 0
	MOVWF      R0+2
	MOVF       _time+3, 0
	MOVWF      R0+3
	INCF       R0+0, 1
	BTFSC      STATUS+0, 2
	INCF       R0+1, 1
	BTFSC      STATUS+0, 2
	INCF       R0+2, 1
	BTFSC      STATUS+0, 2
	INCF       R0+3, 1
	MOVF       R0+0, 0
	MOVWF      _time+0
	MOVF       R0+1, 0
	MOVWF      _time+1
	MOVF       R0+2, 0
	MOVWF      _time+2
	MOVF       R0+3, 0
	MOVWF      _time+3
;MyProject.c,24 :: 		PORTD.B0=1;       //set this pin as 1
	BSF        PORTD+0, 0
;MyProject.c,26 :: 		PORTD.B0=0;       //set it as 0
	BCF        PORTD+0, 0
;MyProject.c,27 :: 		}
L_main3:
;MyProject.c,28 :: 		}
	GOTO       L_main4
L_main2:
;MyProject.c,29 :: 		else if(flag==1)
	MOVF       _flag+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main5
;MyProject.c,31 :: 		PORTD.B0=1;       //set this pin as 1
	BSF        PORTD+0, 0
;MyProject.c,33 :: 		PORTD.B0=0;       //set it as 0
	BCF        PORTD+0, 0
;MyProject.c,34 :: 		PORTD.B1=1; //this pin set to 1
	BSF        PORTD+0, 1
;MyProject.c,35 :: 		if(time==15)
	MOVLW      0
	MOVWF      R0+0
	XORWF      _time+3, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main12
	MOVF       R0+0, 0
	XORWF      _time+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main12
	MOVF       R0+0, 0
	XORWF      _time+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main12
	MOVF       _time+0, 0
	XORLW      15
L__main12:
	BTFSS      STATUS+0, 2
	GOTO       L_main6
;MyProject.c,37 :: 		flag=0;
	CLRF       _flag+0
;MyProject.c,38 :: 		time=0;
	CLRF       _time+0
	CLRF       _time+1
	CLRF       _time+2
	CLRF       _time+3
;MyProject.c,39 :: 		counter=0;
	CLRF       _counter+0
	CLRF       _counter+1
	CLRF       _counter+2
	CLRF       _counter+3
;MyProject.c,40 :: 		PORTD.B1=1;       //set this pin as 1
	BSF        PORTD+0, 1
;MyProject.c,42 :: 		PORTD.B0=0;       //set it as 0
	BCF        PORTD+0, 0
;MyProject.c,43 :: 		PORTD.B1=0; //this pin reset to 0
	BCF        PORTD+0, 1
;MyProject.c,45 :: 		}
L_main6:
;MyProject.c,46 :: 		}
L_main5:
L_main4:
;MyProject.c,47 :: 		}
	GOTO       L_main0
;MyProject.c,48 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;MyProject.c,49 :: 		void interrupt() { // Interrupt handler
;MyProject.c,50 :: 		if(INTF_bit==1){ //EXT int flag
	BTFSS      INTF_bit+0, BitPos(INTF_bit+0)
	GOTO       L_interrupt7
;MyProject.c,51 :: 		flag=1;
	MOVLW      1
	MOVWF      _flag+0
;MyProject.c,52 :: 		INTF_bit=0;                //reset the int flag
	BCF        INTF_bit+0, BitPos(INTF_bit+0)
;MyProject.c,53 :: 		time=0;
	CLRF       _time+0
	CLRF       _time+1
	CLRF       _time+2
	CLRF       _time+3
;MyProject.c,54 :: 		}
L_interrupt7:
;MyProject.c,55 :: 		if (INTCON.TMR0IF==1) { // check for timer 0 interrupt flag
	BTFSS      INTCON+0, 2
	GOTO       L_interrupt8
;MyProject.c,56 :: 		counter++; // increment 1 every interrupt
	MOVF       _counter+0, 0
	MOVWF      R0+0
	MOVF       _counter+1, 0
	MOVWF      R0+1
	MOVF       _counter+2, 0
	MOVWF      R0+2
	MOVF       _counter+3, 0
	MOVWF      R0+3
	INCF       R0+0, 1
	BTFSC      STATUS+0, 2
	INCF       R0+1, 1
	BTFSC      STATUS+0, 2
	INCF       R0+2, 1
	BTFSC      STATUS+0, 2
	INCF       R0+3, 1
	MOVF       R0+0, 0
	MOVWF      _counter+0
	MOVF       R0+1, 0
	MOVWF      _counter+1
	MOVF       R0+2, 0
	MOVWF      _counter+2
	MOVF       R0+3, 0
	MOVWF      _counter+3
;MyProject.c,57 :: 		INTCON.TMR0IF=0; // reset the TMR0IF flag
	BCF        INTCON+0, 2
;MyProject.c,58 :: 		TMR0=6; // store 6 in the TMR0 register
	MOVLW      6
	MOVWF      TMR0+0
;MyProject.c,59 :: 		}
L_interrupt8:
;MyProject.c,61 :: 		}
L_end_interrupt:
L__interrupt14:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

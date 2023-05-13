
_initialize_Interrupt:

;MyProject.c,16 :: 		void initialize_Interrupt(void){
;MyProject.c,17 :: 		TMR0IE_bit=1; // Enable timer 0 interrupt
	BSF        TMR0IE_bit+0, BitPos(TMR0IE_bit+0)
;MyProject.c,18 :: 		GIE_bit=1; //Enable Global Interrupt
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
;MyProject.c,19 :: 		INTE_bit=1; //Enable ext interrupts
	BSF        INTE_bit+0, BitPos(INTE_bit+0)
;MyProject.c,20 :: 		T0CS_bit=0; // Select f/4 clock for the TMR0
	BCF        T0CS_bit+0, BitPos(T0CS_bit+0)
;MyProject.c,21 :: 		PSA_bit=0; // Prescaler is assigned to the Timer0 module
	BCF        PSA_bit+0, BitPos(PSA_bit+0)
;MyProject.c,22 :: 		PS0_bit=0; // Set pre-scaler to 8
	BCF        PS0_bit+0, BitPos(PS0_bit+0)
;MyProject.c,23 :: 		PS1_bit=1; // PS2,PS1,PS0 = 010
	BSF        PS1_bit+0, BitPos(PS1_bit+0)
;MyProject.c,24 :: 		PS2_bit=0; //
	BCF        PS2_bit+0, BitPos(PS2_bit+0)
;MyProject.c,25 :: 		TMR0=6; //counter starting value
	MOVLW      6
	MOVWF      TMR0+0
;MyProject.c,26 :: 		}
L_end_initialize_Interrupt:
	RETURN
; end of _initialize_Interrupt

_main:

;MyProject.c,27 :: 		void main() {
;MyProject.c,28 :: 		Lcd_Init(); // Initiate the LCD
	CALL       _Lcd_Init+0
;MyProject.c,29 :: 		Lcd_Cmd(_LCD_CURSOR_OFF); // Stop the cursor
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,30 :: 		Lcd_Out(1,1,"Elapesed Time:"); // Show elapsed time message
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,31 :: 		initialize_Interrupt(); // invoke interrupt initialization function
	CALL       _initialize_Interrupt+0
;MyProject.c,32 :: 		TRISD.B0=0; // This pin is set as output
	BCF        TRISD+0, 0
;MyProject.c,33 :: 		TRISB.B0=1; //this pin is set as input
	BSF        TRISB+0, 0
;MyProject.c,34 :: 		PORTD.B0=0; //Turn off the motor
	BCF        PORTD+0, 0
;MyProject.c,35 :: 		while(1){
L_main0:
;MyProject.c,36 :: 		if(flag==0){
	MOVF       _flag+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main2
;MyProject.c,37 :: 		PORTD.B0=0; //Turn off the motor
	BCF        PORTD+0, 0
;MyProject.c,39 :: 		if(counter==500){ // check if the counter reaches 125
	MOVF       _counter+1, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L__main11
	MOVLW      244
	XORWF      _counter+0, 0
L__main11:
	BTFSS      STATUS+0, 2
	GOTO       L_main3
;MyProject.c,40 :: 		counter=0; // start counter from the beginning
	CLRF       _counter+0
	CLRF       _counter+1
;MyProject.c,41 :: 		time=time++; // increase time one second
	INCF       _time+0, 1
	BTFSC      STATUS+0, 2
	INCF       _time+1, 1
;MyProject.c,42 :: 		IntToStrWithZeros(time, txt); // convert the number of seconds to string
	MOVF       _time+0, 0
	MOVWF      FARG_IntToStrWithZeros_input+0
	MOVF       _time+1, 0
	MOVWF      FARG_IntToStrWithZeros_input+1
	MOVLW      _txt+0
	MOVWF      FARG_IntToStrWithZeros_output+0
	CALL       _IntToStrWithZeros+0
;MyProject.c,43 :: 		Lcd_Out(2,1,txt); // display the number of seconds
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,44 :: 		}
L_main3:
;MyProject.c,45 :: 		}
	GOTO       L_main4
L_main2:
;MyProject.c,46 :: 		else if(flag==1){
	MOVF       _flag+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main5
;MyProject.c,47 :: 		PORTD.B0=1;
	BSF        PORTD+0, 0
;MyProject.c,48 :: 		time=0;
	CLRF       _time+0
	CLRF       _time+1
;MyProject.c,49 :: 		Lcd_Out(1,1,"Fan IS On:    ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,50 :: 		IntToStrWithZeros(time, txt); // convert the number of seconds to string
	MOVF       _time+0, 0
	MOVWF      FARG_IntToStrWithZeros_input+0
	MOVF       _time+1, 0
	MOVWF      FARG_IntToStrWithZeros_input+1
	MOVLW      _txt+0
	MOVWF      FARG_IntToStrWithZeros_output+0
	CALL       _IntToStrWithZeros+0
;MyProject.c,51 :: 		Lcd_Out(2,1,txt); // display the number of seconds
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,52 :: 		if(PORTB.B0==0)
	BTFSC      PORTB+0, 0
	GOTO       L_main6
;MyProject.c,54 :: 		flag=0;
	CLRF       _flag+0
;MyProject.c,55 :: 		counter=0;
	CLRF       _counter+0
	CLRF       _counter+1
;MyProject.c,56 :: 		Lcd_Out(1,1,"Elapesed Time:");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,57 :: 		}
L_main6:
;MyProject.c,58 :: 		}
L_main5:
L_main4:
;MyProject.c,59 :: 		}
	GOTO       L_main0
;MyProject.c,60 :: 		}
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

;MyProject.c,61 :: 		void interrupt() { // Interrupt handler
;MyProject.c,62 :: 		if(INTF_bit==1){ //EXT int flag
	BTFSS      INTF_bit+0, BitPos(INTF_bit+0)
	GOTO       L_interrupt7
;MyProject.c,63 :: 		flag=1;
	MOVLW      1
	MOVWF      _flag+0
;MyProject.c,64 :: 		INTF_bit=0;                //reset the int flag
	BCF        INTF_bit+0, BitPos(INTF_bit+0)
;MyProject.c,66 :: 		}
L_interrupt7:
;MyProject.c,67 :: 		if (INTCON.TMR0IF==1) { // check for timer 0 interrupt flag
	BTFSS      INTCON+0, 2
	GOTO       L_interrupt8
;MyProject.c,68 :: 		counter++; // increment 1 every interrupt
	INCF       _counter+0, 1
	BTFSC      STATUS+0, 2
	INCF       _counter+1, 1
;MyProject.c,69 :: 		INTCON.TMR0IF=0; // reset the TMR0IF flag
	BCF        INTCON+0, 2
;MyProject.c,70 :: 		TMR0=6; // store 6 in the TMR0 register
	MOVLW      6
	MOVWF      TMR0+0
;MyProject.c,71 :: 		}
L_interrupt8:
;MyProject.c,73 :: 		}
L_end_interrupt:
L__interrupt13:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

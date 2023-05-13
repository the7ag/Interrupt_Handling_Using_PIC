
_initialize_Interrupt:

;MyProject.c,29 :: 		void initialize_Interrupt(void){
;MyProject.c,30 :: 		TMR0IE_bit=1; // Enable timer 0 interrupt
	BSF        TMR0IE_bit+0, BitPos(TMR0IE_bit+0)
;MyProject.c,31 :: 		GIE_bit=1; //Enable Global Interrupt
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
;MyProject.c,32 :: 		T0CS_bit=0; // Select f/4 clock for the TMR0
	BCF        T0CS_bit+0, BitPos(T0CS_bit+0)
;MyProject.c,33 :: 		PSA_bit=0; // Prescaler is assigned to the Timer0 module
	BCF        PSA_bit+0, BitPos(PSA_bit+0)
;MyProject.c,34 :: 		PS0_bit=0; // Set pre-scaler to 8
	BCF        PS0_bit+0, BitPos(PS0_bit+0)
;MyProject.c,35 :: 		PS1_bit=1; // PS2,PS1,PS0 = 010
	BSF        PS1_bit+0, BitPos(PS1_bit+0)
;MyProject.c,36 :: 		PS2_bit=0; //
	BCF        PS2_bit+0, BitPos(PS2_bit+0)
;MyProject.c,37 :: 		TMR0=6; //counter starting value
	MOVLW      6
	MOVWF      TMR0+0
;MyProject.c,38 :: 		}
L_end_initialize_Interrupt:
	RETURN
; end of _initialize_Interrupt

_main:

;MyProject.c,40 :: 		void main() {
;MyProject.c,41 :: 		TRISD.B0=0;                               // This pin is set as output
	BCF        TRISD+0, 0
;MyProject.c,42 :: 		PORTD.B0=0;                               //turn off the motor
	BCF        PORTD+0, 0
;MyProject.c,43 :: 		Keypad_Init();                           // Initialize Keypad
	CALL       _Keypad_Init+0
;MyProject.c,44 :: 		Lcd_Init();                              // Initialize LCD
	CALL       _Lcd_Init+0
;MyProject.c,45 :: 		Lcd_Cmd(_LCD_CLEAR);                     // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,46 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);                // Cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,47 :: 		Lcd_Out(1,1,"Enter Password");           //Print Enter Password on turning on the lcd
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,48 :: 		Lcd_Out(2,1,"");                         //set the cursor on pos 2,1
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,50 :: 		do {
L_main0:
;MyProject.c,51 :: 		kp = 0;                                // Reset key code variable
	CLRF       _kp+0
;MyProject.c,53 :: 		do
L_main3:
;MyProject.c,54 :: 		kp = Keypad_Key_Click();             // Store key code in kp variable
	CALL       _Keypad_Key_Click+0
	MOVF       R0+0, 0
	MOVWF      _kp+0
;MyProject.c,55 :: 		while (!kp);
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main3
;MyProject.c,57 :: 		switch (kp) {
	GOTO       L_main6
;MyProject.c,58 :: 		case  1: kp = '1'; break;    //1
L_main8:
	MOVLW      49
	MOVWF      _kp+0
	GOTO       L_main7
;MyProject.c,59 :: 		case  2: kp = '2'; break; // 2
L_main9:
	MOVLW      50
	MOVWF      _kp+0
	GOTO       L_main7
;MyProject.c,60 :: 		case  3: kp = '3'; break; // 3
L_main10:
	MOVLW      51
	MOVWF      _kp+0
	GOTO       L_main7
;MyProject.c,61 :: 		case  4: kp = 'A'; break; // A
L_main11:
	MOVLW      65
	MOVWF      _kp+0
	GOTO       L_main7
;MyProject.c,62 :: 		case  5: kp = '4'; break; // 4
L_main12:
	MOVLW      52
	MOVWF      _kp+0
	GOTO       L_main7
;MyProject.c,63 :: 		case  6: kp = '5'; break; // 5
L_main13:
	MOVLW      53
	MOVWF      _kp+0
	GOTO       L_main7
;MyProject.c,64 :: 		case  7: kp = '6'; break; // 6
L_main14:
	MOVLW      54
	MOVWF      _kp+0
	GOTO       L_main7
;MyProject.c,65 :: 		case  8: kp = 'B'; break; // B
L_main15:
	MOVLW      66
	MOVWF      _kp+0
	GOTO       L_main7
;MyProject.c,66 :: 		case  9: kp = '7'; break; // 7
L_main16:
	MOVLW      55
	MOVWF      _kp+0
	GOTO       L_main7
;MyProject.c,67 :: 		case 10: kp = '8'; break; // 8
L_main17:
	MOVLW      56
	MOVWF      _kp+0
	GOTO       L_main7
;MyProject.c,68 :: 		case 11: kp = '9'; break; // 9
L_main18:
	MOVLW      57
	MOVWF      _kp+0
	GOTO       L_main7
;MyProject.c,69 :: 		case 12: kp = 'C'; break; // C
L_main19:
	MOVLW      67
	MOVWF      _kp+0
	GOTO       L_main7
;MyProject.c,70 :: 		case 13: kp = '*'; break; // *
L_main20:
	MOVLW      42
	MOVWF      _kp+0
	GOTO       L_main7
;MyProject.c,71 :: 		case 14: kp = '0'; break; // 0
L_main21:
	MOVLW      48
	MOVWF      _kp+0
	GOTO       L_main7
;MyProject.c,72 :: 		case 15: kp = '#'; break; // #
L_main22:
	MOVLW      35
	MOVWF      _kp+0
	GOTO       L_main7
;MyProject.c,73 :: 		case 16: kp = 'D'; break; // D
L_main23:
	MOVLW      68
	MOVWF      _kp+0
	GOTO       L_main7
;MyProject.c,74 :: 		}
L_main6:
	MOVF       _kp+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_main8
	MOVF       _kp+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_main9
	MOVF       _kp+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_main10
	MOVF       _kp+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_main11
	MOVF       _kp+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_main12
	MOVF       _kp+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_main13
	MOVF       _kp+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_main14
	MOVF       _kp+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_main15
	MOVF       _kp+0, 0
	XORLW      9
	BTFSC      STATUS+0, 2
	GOTO       L_main16
	MOVF       _kp+0, 0
	XORLW      10
	BTFSC      STATUS+0, 2
	GOTO       L_main17
	MOVF       _kp+0, 0
	XORLW      11
	BTFSC      STATUS+0, 2
	GOTO       L_main18
	MOVF       _kp+0, 0
	XORLW      12
	BTFSC      STATUS+0, 2
	GOTO       L_main19
	MOVF       _kp+0, 0
	XORLW      13
	BTFSC      STATUS+0, 2
	GOTO       L_main20
	MOVF       _kp+0, 0
	XORLW      14
	BTFSC      STATUS+0, 2
	GOTO       L_main21
	MOVF       _kp+0, 0
	XORLW      15
	BTFSC      STATUS+0, 2
	GOTO       L_main22
	MOVF       _kp+0, 0
	XORLW      16
	BTFSC      STATUS+0, 2
	GOTO       L_main23
L_main7:
;MyProject.c,76 :: 		Lcd_Chr_CP(kp);
	MOVF       _kp+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;MyProject.c,78 :: 		Entered[i++]=kp;
	MOVF       _i+0, 0
	ADDLW      _Entered+0
	MOVWF      FSR
	MOVF       _kp+0, 0
	MOVWF      INDF+0
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;MyProject.c,80 :: 		Delay_ms(400);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      8
	MOVWF      R12+0
	MOVLW      119
	MOVWF      R13+0
L_main24:
	DECFSZ     R13+0, 1
	GOTO       L_main24
	DECFSZ     R12+0, 1
	GOTO       L_main24
	DECFSZ     R11+0, 1
	GOTO       L_main24
;MyProject.c,82 :: 		Lcd_Chr(2,i,'#');
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVF       _i+0, 0
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      35
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;MyProject.c,84 :: 		if(i==4)
	MOVLW      0
	XORWF      _i+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main42
	MOVLW      4
	XORWF      _i+0, 0
L__main42:
	BTFSS      STATUS+0, 2
	GOTO       L_main25
;MyProject.c,88 :: 		for( j=0;j<4;j++)
	CLRF       main_j_L2+0
	CLRF       main_j_L2+1
L_main26:
	MOVLW      128
	XORWF      main_j_L2+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main43
	MOVLW      4
	SUBWF      main_j_L2+0, 0
L__main43:
	BTFSC      STATUS+0, 0
	GOTO       L_main27
;MyProject.c,91 :: 		if(Entered[j]!=Password[j])
	MOVF       main_j_L2+0, 0
	ADDLW      _Entered+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	MOVF       main_j_L2+0, 0
	ADDWF      _Password+0, 0
	MOVWF      FSR
	MOVF       R1+0, 0
	XORWF      INDF+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main29
;MyProject.c,93 :: 		state=1;
	MOVLW      1
	MOVWF      _state+0
;MyProject.c,95 :: 		break;
	GOTO       L_main27
;MyProject.c,96 :: 		}
L_main29:
;MyProject.c,88 :: 		for( j=0;j<4;j++)
	INCF       main_j_L2+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_j_L2+1, 1
;MyProject.c,97 :: 		}
	GOTO       L_main26
L_main27:
;MyProject.c,99 :: 		if(state!=1)
	MOVF       _state+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_main30
;MyProject.c,102 :: 		state=2;
	MOVLW      2
	MOVWF      _state+0
;MyProject.c,103 :: 		}
L_main30:
;MyProject.c,107 :: 		if(state==1)
	MOVF       _state+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main31
;MyProject.c,110 :: 		Lcd_Out(2,1,"Wrong");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr4_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,112 :: 		Delay_ms(4000);
	MOVLW      21
	MOVWF      R11+0
	MOVLW      75
	MOVWF      R12+0
	MOVLW      190
	MOVWF      R13+0
L_main32:
	DECFSZ     R13+0, 1
	GOTO       L_main32
	DECFSZ     R12+0, 1
	GOTO       L_main32
	DECFSZ     R11+0, 1
	GOTO       L_main32
	NOP
;MyProject.c,114 :: 		Lcd_Out(2,1,"     ");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr5_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,116 :: 		Lcd_Out(2,1,"");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr6_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,118 :: 		i=0;
	CLRF       _i+0
	CLRF       _i+1
;MyProject.c,120 :: 		state=0;
	CLRF       _state+0
;MyProject.c,121 :: 		}
	GOTO       L_main33
L_main31:
;MyProject.c,123 :: 		else if(state==2)
	MOVF       _state+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_main34
;MyProject.c,126 :: 		Lcd_Out(2,1,"Right");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr7_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,128 :: 		Delay_ms(1000);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main35:
	DECFSZ     R13+0, 1
	GOTO       L_main35
	DECFSZ     R12+0, 1
	GOTO       L_main35
	DECFSZ     R11+0, 1
	GOTO       L_main35
	NOP
	NOP
;MyProject.c,130 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,132 :: 		initialize_Interrupt();
	CALL       _initialize_Interrupt+0
;MyProject.c,134 :: 		counter = 0;
	CLRF       _counter+0
	CLRF       _counter+1
;MyProject.c,136 :: 		time = 0;
	CLRF       _time+0
	CLRF       _time+1
;MyProject.c,138 :: 		PORTD.B0=1;
	BSF        PORTD+0, 0
;MyProject.c,140 :: 		Lcd_Out(1,1,"Motor On Since:");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr8_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,142 :: 		while(time<4)
L_main36:
	MOVLW      128
	XORWF      _time+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main44
	MOVLW      4
	SUBWF      _time+0, 0
L__main44:
	BTFSC      STATUS+0, 0
	GOTO       L_main37
;MyProject.c,145 :: 		if(counter==500)
	MOVF       _counter+1, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L__main45
	MOVLW      244
	XORWF      _counter+0, 0
L__main45:
	BTFSS      STATUS+0, 2
	GOTO       L_main38
;MyProject.c,147 :: 		counter=0; // start counter from the beginning
	CLRF       _counter+0
	CLRF       _counter+1
;MyProject.c,148 :: 		time=time++; // increase time one second
	INCF       _time+0, 1
	BTFSC      STATUS+0, 2
	INCF       _time+1, 1
;MyProject.c,149 :: 		IntToStrWithZeros(time, txt); // convert the number of seconds to string
	MOVF       _time+0, 0
	MOVWF      FARG_IntToStrWithZeros_input+0
	MOVF       _time+1, 0
	MOVWF      FARG_IntToStrWithZeros_input+1
	MOVLW      _txt+0
	MOVWF      FARG_IntToStrWithZeros_output+0
	CALL       _IntToStrWithZeros+0
;MyProject.c,150 :: 		Lcd_Out(2,1,txt); // display the number of seconds
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,151 :: 		}
L_main38:
;MyProject.c,152 :: 		}
	GOTO       L_main36
L_main37:
;MyProject.c,154 :: 		PORTD.B0=0;
	BCF        PORTD+0, 0
;MyProject.c,156 :: 		strcpy(txt,"000000");
	MOVLW      _txt+0
	MOVWF      FARG_strcpy_to+0
	MOVLW      ?lstr9_MyProject+0
	MOVWF      FARG_strcpy_from+0
	CALL       _strcpy+0
;MyProject.c,158 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,160 :: 		Lcd_Out(1,1,"Enter Password");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr10_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,162 :: 		Lcd_Out(2,1,"");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr11_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,164 :: 		i=0;
	CLRF       _i+0
	CLRF       _i+1
;MyProject.c,166 :: 		state=0;
	CLRF       _state+0
;MyProject.c,167 :: 		}
L_main34:
L_main33:
;MyProject.c,168 :: 		}
L_main25:
;MyProject.c,169 :: 		} while (1);
	GOTO       L_main0
;MyProject.c,171 :: 		}
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

;MyProject.c,172 :: 		void interrupt() { // Interrupt handler
;MyProject.c,173 :: 		if (INTCON.TMR0IF==1) { // check for timer 0 interrupt flag
	BTFSS      INTCON+0, 2
	GOTO       L_interrupt39
;MyProject.c,174 :: 		counter++; // increment 1 every interrupt
	INCF       _counter+0, 1
	BTFSC      STATUS+0, 2
	INCF       _counter+1, 1
;MyProject.c,175 :: 		INTCON.TMR0IF=0; // reset the TMR0IF flag
	BCF        INTCON+0, 2
;MyProject.c,176 :: 		TMR0=6; // store 6 in the TMR0 register
	MOVLW      6
	MOVWF      TMR0+0
;MyProject.c,177 :: 		}
L_interrupt39:
;MyProject.c,178 :: 		}
L_end_interrupt:
L__interrupt47:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

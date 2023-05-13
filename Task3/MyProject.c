/*LCD CONNECTION*/
sbit LCD_RS at RC2_bit;
sbit LCD_EN at RC3_bit;
sbit LCD_D7 at RC7_bit;
sbit LCD_D6 at RC6_bit;
sbit LCD_D5 at RC5_bit;
sbit LCD_D4 at RC4_bit;
sbit LCD_RS_Direction at TRISC2_bit;
sbit LCD_EN_Direction at TRISC3_bit;
sbit LCD_D7_Direction at TRISC7_bit;
sbit LCD_D6_Direction at TRISC6_bit;
sbit LCD_D5_Direction at TRISC5_bit;
sbit LCD_D4_Direction at TRISC4_bit;
/*Keypad connection*/
char  keypadPort at PORTB;
/*Keyboard key, State flag */
unsigned short kp,state = 0;
/*The Password Change this to change the password*/
char *Password="0308";
/*Array to save the Entered password*/
char Entered[4]={0};
/*Buffer to show the current time on */
char txt[7];
/*Flag to detect if there's a digit wrong in the password*/
char flag=0;
/*variables for time and ovf counter and for loop counter*/
int time,counter=0,i=0;
/*INT init*/
void initialize_Interrupt(void){
  TMR0IE_bit=1; // Enable timer 0 interrupt
  GIE_bit=1; //Enable Global Interrupt
  T0CS_bit=0; // Select f/4 clock for the TMR0
  PSA_bit=0; // Prescaler is assigned to the Timer0 module
  PS0_bit=0; // Set pre-scaler to 8
  PS1_bit=1; // PS2,PS1,PS0 = 010
  PS2_bit=0; //
  TMR0=6; //counter starting value
}
/*Main Function*/
void main() {
   TRISD.B0=0;                               // This pin is set as output
   PORTD.B0=0;                               //turn off the motor
   Keypad_Init();                           // Initialize Keypad
   Lcd_Init();                              // Initialize LCD
   Lcd_Cmd(_LCD_CLEAR);                     // Clear display
   Lcd_Cmd(_LCD_CURSOR_OFF);                // Cursor off
   Lcd_Out(1,1,"Enter Password");           //Print Enter Password on turning on the lcd
   Lcd_Out(2,1,"");                         //set the cursor on pos 2,1
   /*Super Lop*/
  do {
    kp = 0;                                // Reset key code variable
    /*Busy wait untill a key is pressed*/
    do
      kp = Keypad_Key_Click();             // Store key code in kp variable
    while (!kp);
   // Prepare value for output, transform key to it's ASCII value
    switch (kp) {
      case  1: kp = '1'; break; //1
      case  2: kp = '2'; break; // 2
      case  3: kp = '3'; break; // 3
      case  4: kp = 'A'; break; // A
      case  5: kp = '4'; break; // 4
      case  6: kp = '5'; break; // 5
      case  7: kp = '6'; break; // 6
      case  8: kp = 'B'; break; // B
      case  9: kp = '7'; break; // 7
      case 10: kp = '8'; break; // 8
      case 11: kp = '9'; break; // 9
      case 12: kp = 'C'; break; // C
      case 13: kp = '*'; break; // *
      case 14: kp = '0'; break; // 0
      case 15: kp = '#'; break; // #
      case 16: kp = 'D'; break; // D
    }
    /*print out the key pressed into the lcd*/
    Lcd_Chr_CP(kp);
    /*Save the current key into the Entered array*/
    Entered[i++]=kp;
    /*Display the charcter for short period*/
    Delay_ms(400);
    /*replace the charcter with # for security*/
    Lcd_Chr(2,i,'#');
    /*if we Entered 4 letters*/
    if(i==4)
    {
      /*loop on all letters entered*/
      int j;
      for( j=0;j<4;j++)
      {
        /*if theres a wrong number state=1 = wrong password*/
        if(Entered[j]!=Password[j])
        {
        state=1;
        /*stop the loop*/
        break;
      }
    }
    /*check if state isn't wrong password*/
    if(state!=1)
    {
      /*turn it into 2 == right password*/
      state=2;
    }
      /*State handling
      state==1 wrong Password
      state ==2 Right Password*/
    if(state==1)
    {
      /*Print Wrong on the side of the password*/
      Lcd_Out(2,1,"Wrong");
      /*Wait for 4 seconds busy wait*/
      Delay_ms(4000);
      /*Clear the printed message*/
      Lcd_Out(2,1,"     ");
      /*set cursor*/
      Lcd_Out(2,1,"");
      /*reset the Entered index*/
      i=0;
      /*reset the state*/
      state=0;
    }
    /*Check if we are in winning state*/
    else if(state==2)
    {
     /*Print right in place of the password*/
      Lcd_Out(2,1,"Right");
      /*Keep it on the lcd for 1 sec*/
      Delay_ms(1000);
      /*Clear the screen of any words*/
      Lcd_Cmd(_LCD_CLEAR);
      /*start timer int with prescalar 8 and f/4*/
      initialize_Interrupt();
      /*reset the ovf counter*/
      counter = 0;
      /*reset the output time*/
      time = 0;
      /*tunr on the motor*/
      PORTD.B0=1;
      /*print This message*/
      Lcd_Out(1,1,"Motor On Since:");
      /*while loop to count the exact amount of time*/
      while(time<4)
      {
        if(counter==500)
        { // check if the counter reaches 500 == 1 sec
          counter=0; // start counter from the beginning
          time=time++; // increase time one second
          IntToStrWithZeros(time, txt); // convert the number of seconds to string
          Lcd_Out(2,1,txt); // display the number of seconds
        }
      }
      /*turn off the Motor*/
      PORTD.B0=0;
      /*clear the buffer that prints the */
      strcpy(txt,"000000");
      /*clear the lcd*/
      Lcd_Cmd(_LCD_CLEAR);
      /*revert back to the old message*/
      Lcd_Out(1,1,"Enter Password");
      /*set the pointer*/
      Lcd_Out(2,1,"");
      /*reset the index*/
      i=0;
      /*reset the state*/
      state=0;
    }
    }
  } while (1);
  /*end of main*/
}
void interrupt() { // Interrupt handler
  if (INTCON.TMR0IF==1) { // check for timer 0 interrupt flag
  counter++; // increment 1 every interrupt
  INTCON.TMR0IF=0; // reset the TMR0IF flag
  TMR0=6; // store 6 in the TMR0 register
  }
}
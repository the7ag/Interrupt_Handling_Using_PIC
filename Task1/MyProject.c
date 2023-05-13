sbit LCD_RS at RC4_bit;
sbit LCD_EN at RC5_bit;
sbit LCD_D7 at RC3_bit;
sbit LCD_D6 at RC2_bit;
sbit LCD_D5 at RC1_bit;
sbit LCD_D4 at RC0_bit;
sbit LCD_RS_Direction at TRISC4_bit;
sbit LCD_EN_Direction at TRISC5_bit;
sbit LCD_D7_Direction at TRISC3_bit;
sbit LCD_D6_Direction at TRISC2_bit;
sbit LCD_D5_Direction at TRISC1_bit;
sbit LCD_D4_Direction at TRISC0_bit;
char txt[7];
char flag=0;
int time,counter=0;
void initialize_Interrupt(void){
  TMR0IE_bit=1; // Enable timer 0 interrupt
  GIE_bit=1; //Enable Global Interrupt
  INTE_bit=1; //Enable ext interrupts
  T0CS_bit=0; // Select f/4 clock for the TMR0
  PSA_bit=0; // Prescaler is assigned to the Timer0 module
  PS0_bit=0; // Set pre-scaler to 8
  PS1_bit=1; // PS2,PS1,PS0 = 010
  PS2_bit=0; //
  TMR0=6; //counter starting value
}
void main() {
  Lcd_Init(); // Initiate the LCD
  Lcd_Cmd(_LCD_CURSOR_OFF); // Stop the cursor
  Lcd_Out(1,1,"Elapesed Time:"); // Show elapsed time message
  initialize_Interrupt(); // invoke interrupt initialization function
  TRISD.B0=0; // This pin is set as output
  TRISB.B0=1; //this pin is set as input
  PORTD.B0=0; //Turn off the motor
  while(1){
    if(flag==0){
      PORTD.B0=0; //Turn off the motor

      if(counter==500){ // check if the counter reaches 125
        counter=0; // start counter from the beginning
        time=time++; // increase time one second
        IntToStrWithZeros(time, txt); // convert the number of seconds to string
        Lcd_Out(2,1,txt); // display the number of seconds
      }
    }
    else if(flag==1){
      PORTD.B0=1;
      time=0;
      Lcd_Out(1,1,"Fan IS On:    ");
      IntToStrWithZeros(time, txt); // convert the number of seconds to string
      Lcd_Out(2,1,txt); // display the number of seconds
      if(PORTB.B0==0)
      {
      flag=0;
      counter=0;
      Lcd_Out(1,1,"Elapesed Time:");
      }
    }
  }
}
void interrupt() { // Interrupt handler
  if(INTF_bit==1){ //EXT int flag
    flag=1;
    INTF_bit=0;                //reset the int flag

  }
  if (INTCON.TMR0IF==1) { // check for timer 0 interrupt flag
  counter++; // increment 1 every interrupt
  INTCON.TMR0IF=0; // reset the TMR0IF flag
  TMR0=6; // store 6 in the TMR0 register
  }

}
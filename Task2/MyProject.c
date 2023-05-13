long long int time,counter=0;
char flag=0;
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
  initialize_Interrupt(); // invoke interrupt initialization function
  TRISD.B0=0; // This pin is set as output
  TRISD.B1=0; // This pin is set as output
  PORTD.B1=0; //this pin reset to 0
  while(1){
  if(flag==0){
      if(counter==500){ // check if the counter reaches 125
        counter=0; // start counter from the beginning
        time=time++; // increase time one second
        PORTD.B0=1;       //set this pin as 1
        Delay_1us;        //small delay
        PORTD.B0=0;       //set it as 0
      }
    }
    else if(flag==1)
    {
    PORTD.B0=1;       //set this pin as 1
    Delay_1us;        //small delay
    PORTD.B0=0;       //set it as 0
	PORTD.B1=1; //this pin set to 1
    if(time==15)
    {
        flag=0;
        time=0;
        counter=0;
        PORTD.B1=1;       //set this pin as 1
        Delay_1us;        //small delay
        PORTD.B0=0;       //set it as 0
		PORTD.B1=0; //this pin reset to 0
		
    }
    }
  }
}
void interrupt() { // Interrupt handler
  if(INTF_bit==1){ //EXT int flag
    flag=1;
    INTF_bit=0;                //reset the int flag
     time=0;
  }
  if (INTCON.TMR0IF==1) { // check for timer 0 interrupt flag
  counter++; // increment 1 every interrupt
  INTCON.TMR0IF=0; // reset the TMR0IF flag
  TMR0=6; // store 6 in the TMR0 register
  }

}
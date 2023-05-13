#line 1 "F:/Tasks/College/Second Term/LAPS/Lap 8 Mahmoud/Task2/MyProject.c"
long long int time,counter=0;
char flag=0;
void initialize_Interrupt(void){
 TMR0IE_bit=1;
 GIE_bit=1;
 INTE_bit=1;
 T0CS_bit=0;
 PSA_bit=0;
 PS0_bit=0;
 PS1_bit=1;
 PS2_bit=0;
 TMR0=6;
}
void main() {
 initialize_Interrupt();
 TRISD.B0=0;
 TRISD.B1=0;
 PORTD.B1=0;
 while(1){
 if(flag==0){
 if(counter==500){
 counter=0;
 time=time++;
 PORTD.B0=1;
 Delay_1us;
 PORTD.B0=0;
 }
 }
 else if(flag==1)
 {
 PORTD.B0=1;
 Delay_1us;
 PORTD.B0=0;
 PORTD.B1=1;
 if(time==15)
 {
 flag=0;
 time=0;
 counter=0;
 PORTD.B1=1;
 Delay_1us;
 PORTD.B0=0;
 PORTD.B1=0;

 }
 }
 }
}
void interrupt() {
 if(INTF_bit==1){
 flag=1;
 INTF_bit=0;
 time=0;
 }
 if (INTCON.TMR0IF==1) {
 counter++;
 INTCON.TMR0IF=0;
 TMR0=6;
 }

}

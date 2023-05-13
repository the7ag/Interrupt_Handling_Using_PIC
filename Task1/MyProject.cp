#line 1 "F:/Tasks/College/Second Term/LAPS/Lap 8 Mahmoud/Code/MyProject.c"
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
 Lcd_Init();
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1,1,"Elapesed Time:");
 initialize_Interrupt();
 TRISD.B0=0;
 TRISB.B0=1;
 PORTD.B0=0;
 while(1){
 if(flag==0){
 PORTD.B0=0;

 if(counter==500){
 counter=0;
 time=time++;
 IntToStrWithZeros(time, txt);
 Lcd_Out(2,1,txt);
 }
 }
 else if(flag==1){
 PORTD.B0=1;
 time=0;
 Lcd_Out(1,1,"Fan IS On:    ");
 IntToStrWithZeros(time, txt);
 Lcd_Out(2,1,txt);
 if(PORTB.B0==0)
 {
 flag=0;
 counter=0;
 Lcd_Out(1,1,"Elapesed Time:");
 }
 }
 }
}
void interrupt() {
 if(INTF_bit==1){
 flag=1;
 INTF_bit=0;

 }
 if (INTCON.TMR0IF==1) {
 counter++;
 INTCON.TMR0IF=0;
 TMR0=6;
 }

}

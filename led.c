/*
 * led.c
 *
 * Created on: Apr 8, 2020
 *     Author: Jeffrey Paine
 */


#ifndef F_CPU
#define F_CPU 16000000UL 
#endif

#include <avr/io.h>
#include <util/delay.h>                // for _delay_ms()

int main(void)
{
    DDRB |= _BV(DDB5);                 // initialize port B

    ledInit();

    while(1)
    {
        // LED on
        PORTB |= _BV(PORTB5);          // PB5 = High = Vcc
        _delay_ms(5000);               // wait 500 milliseconds

        //LED off
        PORTB &= ~_BV(PORTB5);         // PB5 = Low = 0v
        _delay_ms(5000);               // wait 500 milliseconds
    }
}

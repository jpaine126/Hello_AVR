PKG=led
BIN=${PKG}
OBJS=${PKG}.o

MCU=atmega328p
DF_CPU=16000000UL

PORT=/dev/tty.usbmodem142101



CC=avr-gcc
OBJCOPY=avr-objcopy

CFLAGS=-Os -DF_CPU=${DF_CPU} -mmcu=${MCU}

ODIR=debug 
LDIR=../lib

${BIN}.hex: ${BIN}.elf
	@echo 'Invoking: Cross AVR GNU Create Flash Image'
	${OBJCOPY} -O ihex -R .eeprom $< $@
	#${OBJCOPY} -O ihex $< $@
	@echo 'Finished Building: $@'
	@echo ''

${BIN}.elf: ${OBJS}
	@echo ''
	@echo 'Building Target: $@'
	@echo 'Invoking: Cross AVR GNU C++ Linker'
	${CC} -mmcu=${MCU} -o $@ $^
	@echo 'Finished Building Target: $@'
	@echo ''

install: ${BIN}.hex
	@echo 'Flashing to Target MCU'
	avrdude -F -V -c arduino -p ${MCU} -P ${PORT} -b 115200 -U flash:w:$^
	@echo 'Finished Flashing'
	@echo ''

.PHONY: clean

clean:
	rm -f ${BIN}.o ${BIN}.elf ${BIN}.hex *~ core *~ 
PROJECT		= nametag
F_CPU 		= 1000000
PART		= attiny85
CFLAGS		= -Wall -mmcu=$(PART) -DF_CPU=$(F_CPU) -Os
OBJECTS		= $(PROJECT).o
CC		= avr-g++
P 		= $(PROJECT).hex
OBJCOPY 	= avr-objcopy

all: $(P)

%.hex: %.o
	$(OBJCOPY) -Oihex $< $@

%.o: %.c %.h
	$(CC) $(CFLAGS) -o $@ $<

install:
	avrdude -c dragon_isp -P usb -p $(PART) -U flash:w:$(P)

binary: $(PROJECT).bin

$(PROJECT).bin: $(OBJECTS)
	$(OBJCOPY) -Obinary $(OBJECTS) $(PROJECT).bin

all: $(P) binary

size: $(OBJECTS)
	avr-size $(OBJECTS)

clean:
	rm *.bin *.hex *.o

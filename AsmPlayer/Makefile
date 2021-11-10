
SRC = demo.asm demo.c

all: zx.tap msx.dsk cpc.dsk

clean:
	rm -f *.tap *.bin *.img *.msx *.cpc *.dsk *.map

zx.tap: $(SRC)
	zcc +zx -lndos $+ wyzproplay_zx.asm -o zx.bin -create-app

msx.dsk: $(SRC)
	zcc +msx -subtype=disk $+ wyzproplay_msx.asm -o msx.bin -create-app
	mv msx.img msx.dsk

cpc.dsk: $(SRC)
	zcc +cpc -lndos -subtype=dsk -Ca-DCPC $+ wyzproplay_cpc.asm -o cpc.bin -create-app

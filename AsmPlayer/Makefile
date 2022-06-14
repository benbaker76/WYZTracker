
SRC = demo.asm demo.c

all: zx.tap msx.dsk cpc.dsk

clean:
	rm -f *.tap *.bin *.img *.msx *.cpc *.dsk *.map

zx.tap: $(SRC) wyzproplay_zx.asm
	zcc +zx -lndos $+ -o zx.bin -create-app

msx.dsk: $(SRC) wyzproplay_msx.asm
	zcc +msx -subtype=disk $+ -o msx.bin -create-app
	mv msx.img msx.dsk

cpc.dsk: $(SRC) wyzproplay_cpc.asm
	zcc +cpc -lndos -subtype=dsk -Ca-DCPC $+ -o cpc.bin -create-app

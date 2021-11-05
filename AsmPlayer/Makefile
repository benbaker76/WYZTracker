
all: zx.tap msx.img cpc.dsk

clean:
	rm -f *.tap *.bin *.img *.msx *.cpc *.dsk *.map

zx.tap: demo.asm 
	zcc +zx demo.asm wyzproplay_zx.asm -o zx.bin -create-app

msx.img: demo.asm
	zcc +msx -subtype=disk demo.asm wyzproplay_msx.asm -o msx.bin -create-app

cpc.dsk: demo.asm
	zcc +cpc -subtype=dsk -Ca-DCPC demo.asm wyzproplay_cpc.asm -o cpc.bin -create-app

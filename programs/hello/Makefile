all: hello.rom

hello.rom: hello.asm
	xa hello.asm -o hello.rom
	dd if=/dev/zero bs=16k count=7 2>/dev/null >> hello.rom # I have a 128k ROM, so padding is needed

burn: hello.rom
	sudo minipro -p W27C010 -w hello.rom &
	sleep 5.2
	sudo kill `pgrep minipro` # save time by stopping after ~16k

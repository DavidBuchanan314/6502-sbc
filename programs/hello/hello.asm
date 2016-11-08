UART_CTRL = $A000
UART_DATA = $A001
ROM_START = $C000

* = ROM_START

UART_init:
	LDA #%00000011			; Master reset
	STA UART_CTRL
	LDA #%00010101
	STA UART_CTRL
	RTS

UART_putc: .(
	PHA				; save accumulator
loop:
	LDA	UART_CTRL
	AND	#$02			; Is tx buffer full?
	BEQ	loop			; if so, loop back
	PLA				; Otherwise, restore accumulator
	STA	UART_DATA		; write byte to UART
	RTS
.)

main: .(
	LDA	#0
	LDX	#0
delay:					; lazy way of debouncing the reset button...
	DEX
	BNE	delay
	DEC
	BNE	delay
	
	LDX	#$FF			; setup stack
	TXS
	
	JSR	UART_init
	
	LDX	#0
printloop:
	LDA	message, x
	BEQ	halt
	JSR	UART_putc
	INX
	JMP	printloop
.)

halt:
	JMP	halt

message:
.asc	"Hello, world!", $0D, $0A

.dsb	$fffa-*, 0

.word	0				; NMI
.word	main				; RESET
.word	0				; IRQ

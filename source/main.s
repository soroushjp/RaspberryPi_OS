.section .init
.globl _start
_start:

# Set GPIO Address for RPi
ldr r0,=0x20200000

# Initialize GPIO Pin Output
mov r1,#1
lsl r1,#18
str r1,[r0,#4]

mov r1,#1
lsl r1,#16

flashloop$:

	# Turn off GPIO Pin 16 output (to turn on ACT LED)
	str r1,[r0,#40]

	# Wait an arbitrary amount of time by subtracting 1 from 0x3F0000 per cycle 
	mov r2,#0x3F0000

	wait1$:
		sub r2,#1
		cmp r2,#0
		bne wait1$

	# Turn on GPIO Pin 16 output (to turn off ACT LED)
	str r1,[r0,#28]

	# Wait an arbitrary amount of time by subtracting 1 from 0x3F0000 per cycle 
	mov r2,#0x3F0000

	wait2$:
		sub r2,#1
		cmp r2,#0
		bne wait2$

	# Start at top with LED turn on again
	b flashloop$

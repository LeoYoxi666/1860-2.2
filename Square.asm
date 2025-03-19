// Load x from R0
@R0
D=M

// Store x in TEMP_X to avoid modifying R0
@TEMP_X
M=D  

// Initialize result y = 0 in R1
@R1
M=0  

// If x == 0, result is 0, so jump to END
@CHECK_ZERO
D;JEQ  

// Set up loop counter (x times)
@TEMP_X
D=M
@LOOP
M=D  

// Square calculation: y += x, repeated x times
(SQUARE_LOOP)
@LOOP
D=M
@END
D;JEQ  // If counter is 0, stop

@R1
D=M
@TEMP_X
D=D+M  // y = y + x
@R1
M=D  // Store new y

// Decrement loop counter
@LOOP
M=M-1
@SQUARE_LOOP
0;JMP  // Repeat loop

(END)

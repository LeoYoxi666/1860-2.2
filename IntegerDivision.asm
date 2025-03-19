// Load x (dividend) into D
@R0
D=M

// Load y (divisor) into A and check if zero
@R1
A=M
D=A
@DIV_BY_ZERO
D;JEQ  // Jump to error handling if y == 0

// Initialize quotient (m) and remainder (q)
@R2
M=0  // m = 0 (initialize quotient)
@R3
M=0  // q = 0 (initialize remainder)

// Load dividend x again
@R0
D=M
@TEMP_X
M=D  // Store x in TEMP_X

// Load divisor y
@R1
D=M
@TEMP_Y
M=D  // Store y in TEMP_Y

// Set sign flags for x and y
@R0
D=M
@NEG_X
D;JLT  // If x < 0, jump to NEG_X

@R1
D=M
@NEG_Y
D;JLT  // If y < 0, jump to NEG_Y

// Absolute values are now stored in TEMP_X and TEMP_Y
// Start computing integer division using subtraction
(LOOP)
@TEMP_X
D=M
@TEMP_Y
D=D-M
@END_DIV
D;JLT  // Stop if x - y < 0

@TEMP_X
M=D  // Store new x
@R2
M=M+1  // Increment quotient (m)
@LOOP
0;JMP  // Repeat

(END_DIV)
// Store remainder
@TEMP_X
D=M
@R3
M=D  // Store q

// Set flag R4 = 0 (valid division)
@R4
M=0
@END
0;JMP

// Handle division by zero case
(DIV_BY_ZERO)
@R4
M=1  // Set error flag
@END
0;JMP

// Handle negative x
(NEG_X)
@TEMP_X
M=-M  // Convert x to positive
@R0
D=M
@SIGN_X
M=D  // Store sign of x
@LOOP
0;JMP

// Handle negative y
(NEG_Y)
@TEMP_Y
M=-M  // Convert y to positive
@R1
D=M
@SIGN_Y
M=D  // Store sign of y
@LOOP
0;JMP

(END)


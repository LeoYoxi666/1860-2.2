// Load x (dividend) into D
@R0
D=M

// Load y (divisor) and check if zero
@R1
D=M
@DIV_BY_ZERO
D;JEQ  // If y == 0, jump to error handling

// Initialize quotient (m) and remainder (q)
@R2
M=0  // m = 0
@R3
M=0  // q = 0

// Check if x is negative
@R0
D=M
@NEG_X
D;JLT  // If x < 0, jump to NEG_X

// Check if y is negative
@R1
D=M
@NEG_Y
D;JLT  // If y < 0, jump to NEG_Y

// Convert both to positive values if needed
@ABS_X
0;JMP

(NEG_X)
@R0
M=-M  // Convert x to positive
@NEG_FLAG_X
M=1   // Set flag for x being negative
@ABS_X
0;JMP

(NEG_Y)
@R1
M=-M  // Convert y to positive
@NEG_FLAG_Y
M=1   // Set flag for y being negative
@ABS_X
0;JMP

(ABS_X)
// Load absolute values of x and y
@R0
D=M
@TEMP_X
M=D  // Store |x|

@R1
D=M
@TEMP_Y
M=D  // Store |y|

// Perform integer division using subtraction
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

// Restore the sign of quotient (m) if x and y had different signs
@NEG_FLAG_X
D=M
@NEG_FLAG_Y
D=D-M  // Check if x and y had different signs
@NEG_M
D;JNE  // If different signs, negate m
@END_SIGN
0;JMP

(NEG_M)
@R2
M=-M  // Negate quotient
@END_SIGN
0;JMP

(END_SIGN)
// Restore remainder sign to match x
@NEG_FLAG_X
D=M
@NO_CHANGE_Q
D;JEQ  // If x was positive, no change to remainder

@R3
M=-M  // Negate remainder

(NO_CHANGE_Q)
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

(END)


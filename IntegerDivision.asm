// IntegerDivision.asm
// Compute the integer quotient and remainder of x / y
// x is stored in R0, y is stored in R1
// Quotient m is stored in R2, remainder q is stored in R3
// R4 is a flag: 1 if division is invalid, 0 otherwise

@R1
D=M         // Load the value of R1 (y) into D register

@INVALID
D;JEQ       // If y == 0, jump to INVALID (division by zero is invalid)

@R0
D=M         // Load the value of R0 (x) into D register

@R2
M=0         // Initialize quotient m (R2) to 0

@R3
M=D         // Initialize remainder q (R3) to x

@SIGN_CHECK
D;JLT       // If x is negative, jump to SIGN_CHECK

(LOOP)
@R3
D=M         // Load the value of R3 (remainder q) into D register

@R1
D=D-M       // Subtract y from q

@END_LOOP
D;JLT       // If q < y, jump to END_LOOP

@R2
M=M+1       // Increment quotient m by 1

@R3
M=D         // Update remainder q

@LOOP
0;JMP       // Repeat the loop

(END_LOOP)
@R0
D=M         // Load the value of R0 (x) into D register

@R3
D=M         // Load the value of R3 (remainder q) into D register

@SAME_SIGN
D;JGE       // If q has the same sign as x, jump to SAME_SIGN

@R1
D=M         // Load the value of R1 (y) into D register

@R3
M=M+D       // Adjust remainder q to have the same sign as x

@R2
M=M-1       // Adjust quotient m accordingly

(SAME_SIGN)
@R4
M=0         // Set flag R4 to 0 (division is valid)

@END
0;JMP       // Jump to END

(INVALID)
@R4
M=1         // Set flag R4 to 1 (division is invalid)

@END
0;JMP       // Jump to END

(SIGN_CHECK)
@R0
D=M         // Load the value of R0 (x) into D register

@R3
M=-D        // Initialize remainder q to -x

@LOOP
0;JMP       // Jump to LOOP

(END)
@END
0;JMP       // Infinite loop to end the program
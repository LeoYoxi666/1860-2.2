// IntegerDivision.asm
// Computes signed integer division: x ÷ y = q with remainder r
// Inputs:
//   R0 = x (dividend, signed)
//   R1 = y (divisor, signed)
// Outputs:
//   R2 = q (quotient, signed)
//   R3 = r (remainder, same sign as x)
//   R4 = 1 if invalid (division by 0 or overflow), 0 otherwise
// Internal usage:
//   R5 = sign of x (1 if negative, 0 if positive)
//   R6 = sign of y (1 if negative, 0 if positive)
//   R7 = abs(x)
//   R8 = abs(y)
//   R9 = remainder during division

// ==== Check for divide-by-zero ====
@R1
D=M             // Load y (divisor)
@DIV_BY_ZERO
D;JEQ           // If y == 0, jump to error handler

// ==== Take absolute value of x, and record sign in R5 ====
@R0
D=M             // Load x
@R5
M=0             // Assume x is non-negative (sign = 0)
@X_POSITIVE
D;JGE           // If x >= 0, skip negation
@R5
M=1             // Set sign bit: x is negative
D=-D            // Take abs(x)
(X_POSITIVE)
@R7
M=D             // Store abs(x) in R7

// ==== Take absolute value of y, and record sign in R6 ====
@R1
D=M             // Load y
@R6
M=0             // Assume y is non-negative
@Y_POSITIVE
D;JGE
@R6
M=1             // Set sign bit: y is negative
D=-D            // Take abs(y)
(Y_POSITIVE)
@R8
M=D             // Store abs(y) in R8

// ==== Handle special overflow case: x = -32768, y = -1 ====
@R7
D=M
@32768
D=D-A           // Check if abs(x) == 32768
@NO_OVERFLOW
D;JNE
@R8
D=M
@1
D=D-A           // Check if abs(y) == 1
@NO_OVERFLOW
D;JNE
@OVERFLOW_ERR   // If both hold, overflow
0;JMP

(NO_OVERFLOW)
// ==== Initialize quotient and remainder ====
@R7
D=M
@R9
M=D             // R9 = abs(x) = remainder

@R2
M=0             // R2 = 0, quotient starts from 0

// ==== Division loop: subtract abs(y) from abs(x) until remainder < abs(y) ====
(DIV_LOOP)
@R9
D=M
@R8
D=D-M
@DIV_DONE
D;JLT           // If remainder < abs(y), done

@R9
M=M-D           // remainder -= abs(y)
@R2
M=M+1           // quotient += 1
@DIV_LOOP
0;JMP

// ==== Post-processing: restore signs ====
(DIV_DONE)

// ---- Fix quotient sign if x and y had different signs ----
@R5
D=M
@R6
D=D-M           // Compare signs
@SKIP_Q_SIGN
D;JEQ           // If signs match, skip negation

@R2
M=-M            // Negate quotient
(SKIP_Q_SIGN)

// ---- Fix remainder sign to match x ----
@R5
D=M
@SKIP_R_SIGN
D;JEQ           // If x was positive, no need to negate
@R9
M=-M            // Negate remainder
(SKIP_R_SIGN)

@R9
D=M
@R3
M=D             // Store remainder in R3

@R4
M=0             // Valid division (no error)

@END
0;JMP

// ==== Divide-by-zero error handler ====
(DIV_BY_ZERO)
@R2
M=0             // Set quotient to 0
@R3
M=0             // Set remainder to 0
@R4
M=1             // Set error flag
@END
0;JMP

// ==== Overflow error handler ====
(OVERFLOW_ERR)
@R2
M=0             // Set quotient to 0
@R3
M=0             // Set remainder to 0
@R4
M=1             // Set error flag
@END
0;JMP

// ==== End of program ====
(END)
@END
0;JMP           // Infinite loop to halt

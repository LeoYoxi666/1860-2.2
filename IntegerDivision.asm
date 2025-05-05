// Check if divisor is zero
@R1
D=M
@BAD_DIV
D;JEQ          // Jump if R1 == 0 (invalid)

// Set valid division flag to 0 (default)
@R4
M=0

// Save inputs x = R0, y = R1
@R0
D=M
@R5           // R5 = x
M=D
@R1
D=M
@R6           // R6 = y
M=D

// ----- Determine if we need to negate quotient -----

// Initialize negate_quotient = false
@R7
M=0           // R7 = 0 means result stays positive

// Check if x < 0
@R5
D=M
@X_NEG
D;JLT
@CHECK_Y
0;JMP
(X_NEG)
@R5
M=-M          // x = -x (make positive)
@R7
M=M+1         // Toggle negate_quotient = 1
(CHECK_Y)

// Check if y < 0
@R6
D=M
@Y_NEG
D;JLT
@PREP_DIV
0;JMP
(Y_NEG)
@R6
M=-M          // y = -y
@R7
M=M+1         // Toggle again

// At this point, if R7 == 1, quotient should be negative
(PREP_DIV)

// Save original x sign for remainder correction
@R0
D=M
@R8
M=0
D;JLT
@SKIP_NEG_REM
@R8
M=1          // R8 = 1 if original x was negative
(SKIP_NEG_REM)

// ----- Division via loop subtraction -----
@R5
D=M
@R9
M=0          // R9 = quotient
(DIV_LOOP2)
@R5
D=M
@R6
D=D-M
@DONE_DIV
D;JLT         // if x < y, exit
@R5
M=M-D         // x -= y
@R9
M=M+1         // quotient++
@DIV_LOOP2
0;JMP
(DONE_DIV)

// ----- Write quotient to R2 -----
@R7
D=M
@NEGATE_Q
D;JEQ
@R9
D=M
@R2
M=-D         // Quotient is negative
@REM_CORR
0;JMP
(NEGATE_Q)
@R9
D=M
@R2
M=D          // Quotient is positive

// ----- Correct sign of remainder -----
(REM_CORR)
@R5
D=M
@R8
D=D
@KEEP_POS
@R3
M=D
@R8
D=M
@END
D;JEQ
@R3
M=-M
(KEEP_POS)

// ----- Done -----
@END
0;JMP

// ----- Handle divide by zero -----
(BAD_DIV)
@R4
M=1
@END
0;JMP

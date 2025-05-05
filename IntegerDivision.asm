// Check if R1 (divisor) == 0
@R1
D=M
@INVALID_DIVISION // If y == 0, jump to invalid division handler
D;JEQ

// ----- Compute absolute value of x (R0) -----
@R0
D=M         // D = x
@temp_x
M=D         // Save original x to temp_x
@x_abs
M=D         // Assume x is positive
@X_POS
D;JGE       // If x >= 0, skip negation
@x_abs
M=-M        // If x < 0, negate it: x_abs = -x
(X_POS)

// ----- Compute absolute value of y (R1) -----
@R1
D=M         // D = y
@temp_y
M=D         // Save original y to temp_y
@y_abs
M=D         // Assume y is positive
@Y_POS
D;JGE       // If y >= 0, skip negation
@y_abs
M=-M        // If y < 0, negate it: y_abs = -y
(Y_POS)

// ----- Initialize remainder and unsigned quotient -----
@x_abs
D=M         // D = |x|
@rem
M=D         // rem = |x|
@m_unsigned
M=0         // m_unsigned = 0 (initialize quotient)

// ----- Perform unsigned division: while rem >= y_abs -----
(LOOP_DIV)
@rem
D=M
@y_abs
D=D-M
@END_LOOP_DIV
D;JLT       // If rem < y_abs, exit loop

// rem = rem - y_abs
@y_abs
D=M
@rem
M=M-D

// m_unsigned = m_unsigned + 1
@m_unsigned
M=M+1

@LOOP_DIV
0;JMP       // Repeat loop
(END_LOOP_DIV)

// ----- Determine sign of x -----
@temp_x
D=M
@SIGN_X_NEGATIVE
D;JLT       // If x < 0, jump
@sign_x
M=1         // x >= 0 → sign_x = +1
@CHECK_SIGN_Y
0;JMP
(SIGN_X_NEGATIVE)
@sign_x
M=-1        // x < 0 → sign_x = -1

// ----- Determine sign of y -----
(CHECK_SIGN_Y)
@temp_y
D=M
@SIGN_Y_NEGATIVE
D;JLT       // If y < 0, jump
@sign_y
M=1         // y >= 0 → sign_y = +1
@COMPARE_SIGNS
0;JMP
(SIGN_Y_NEGATIVE)
@sign_y
M=-1        // y < 0 → sign_y = -1

// ----- Compare signs to determine sign of quotient -----
(COMPARE_SIGNS)
@sign_x
D=M
@sign_y
D=D-M       // D = sign_x - sign_y
@SAME_SIGNS
D;JEQ       // If same, m is positive
@sign_m
M=-1        // Opposite signs → quotient is negative
@ADJUST_M
0;JMP
(SAME_SIGNS)
@sign_m
M=1         // Same signs → quotient is positive

// ----- Apply sign to m (quotient) -----
(ADJUST_M)
@sign_m
D=M
@ADJUST_M_NEG
D;JLT       // If sign_m < 0 → negate quotient
@m_unsigned
D=M
@R2
M=D         // Store m = +m_unsigned
@ADJUST_Q
0;JMP
(ADJUST_M_NEG)
@m_unsigned
D=M
@R2
M=-D        // Store m = -m_unsigned

// ----- Apply sign of x to q (remainder) -----
(ADJUST_Q)
@sign_x
D=M
@ADJUST_Q_NEG
D;JLT       // If x < 0, negate remainder
@rem
D=M
@R3
M=D         // q = +remainder
@SET_R4
0;JMP
(ADJUST_Q_NEG)
@rem
D=M
@R3
M=-D        // q = -remainder

// ----- Set valid division flag: R4 = 0 -----
(SET_R4)
@R4
M=0         // Valid division

@END
0;JMP       // End program

// ----- Handle division by zero -----
(INVALID_DIVISION)
@R4
M=1         // Set invalid division flag

(END)
@END
0;JMP       // Infinite loop to end program

// IntegerDivision.asm
@R1
D=M
@INVALID_DIVISION
D;JEQ

// Compute absolute value of x (R0)
@R0
D=M
@temp_x
M=D
@x_abs
M=D
@X_POS
D;JGE
@x_abs
M=-M
(X_POS)

// Compute absolute value of y (R1)
@R1
D=M
@temp_y
M=D
@y_abs
M=D
@Y_POS
D;JGE
@y_abs
M=-M
(Y_POS)

// Initialize remainder and unsigned quotient
@x_abs
D=M
@rem
M=D
@m_unsigned
M=0

// Perform unsigned division
(LOOP_DIV)
@rem
D=M
@y_abs
D=D-M
@END_LOOP_DIV
D;JLT

@y_abs
D=M
@rem
M=M-D
@m_unsigned
M=M+1
@LOOP_DIV
0;JMP
(END_LOOP_DIV)

// Determine sign of x
@temp_x
D=M
@SIGN_X_NEGATIVE
D;JLT
@sign_x
M=1
@CHECK_SIGN_Y
0;JMP
(SIGN_X_NEGATIVE)
@sign_x
M=-1

// Determine sign of y
(CHECK_SIGN_Y)
@temp_y
D=M
@SIGN_Y_NEGATIVE
D;JLT
@sign_y
M=1
@COMPARE_SIGNS
0;JMP
(SIGN_Y_NEGATIVE)
@sign_y
M=-1

// Compare signs to determine quotient's sign
(COMPARE_SIGNS)
@sign_x
D=M
@sign_y
D=D-M
@SAME_SIGNS
D;JEQ
@sign_m
M=-1
@ADJUST_M
0;JMP
(SAME_SIGNS)
@sign_m
M=1

// Adjust quotient based on sign_m
(ADJUST_M)
@sign_m
D=M
@ADJUST_M_NEG
D;JLT
@m_unsigned
D=M
@R2
M=D
@ADJUST_Q
0;JMP
(ADJUST_M_NEG)
@m_unsigned
D=M
@R2
M=-D

// Adjust remainder based on sign_x
(ADJUST_Q)
@sign_x
D=M
@ADJUST_Q_NEG
D;JLT
@rem
D=M
@R3
M=D
@SET_R4
0;JMP
(ADJUST_Q_NEG)
@rem
D=M
@R3
M=-D

// Set valid division flag
(SET_R4)
@R4
M=0
@END
0;JMP

// Handle division by zero
(INVALID_DIVISION)
@R4
M=1

(END)
@END
0;JMP
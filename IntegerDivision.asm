// IntegerDivision.asm

// Check if divisor (R1) is zero
@R1
D=M
@INVALID_DIVISION    // Jump to invalid division handling if divisor is zero
D;JEQ

// Compute absolute value of x (R0)
@R0
D=M
@temp_x             // Store original x value temporarily
M=D
@x_abs              // Store absolute value of x
M=D
@X_POS              // Skip negation if x is non-negative
D;JGE
@x_abs
M=-M                // Take absolute value if x is negative
(X_POS)

// Compute absolute value of y (R1)
@R1
D=M
@temp_y             // Store original y value temporarily
M=D
@y_abs              // Store absolute value of y
M=D
@Y_POS              // Skip negation if y is non-negative
D;JGE
@y_abs
M=-M                // Take absolute value if y is negative
(Y_POS)

// Initialize remainder (rem) and unsigned quotient (m_unsigned)
@x_abs
D=M
@rem                // Initialize remainder with |x|
M=D
@m_unsigned         // Initialize quotient to 0
M=0

// Perform unsigned division via repeated subtraction
(LOOP_DIV)
@rem
D=M
@y_abs
D=D-M               // Subtract |y| from remainder
@END_LOOP_DIV       // Exit loop if remainder < |y|
D;JLT

@y_abs
D=M
@rem
M=M-D               // Update remainder
@m_unsigned
M=M+1               // Increment quotient
@LOOP_DIV
0;JMP               // Continue loop
(END_LOOP_DIV)

// Determine the sign of x
@temp_x
D=M
@SIGN_X_NEGATIVE    // Jump if x is negative
D;JLT
@sign_x
M=1                 // x is positive, sign = 1
@CHECK_SIGN_Y
0;JMP
(SIGN_X_NEGATIVE)
@sign_x
M=-1                // x is negative, sign = -1

// Determine the sign of y
(CHECK_SIGN_Y)
@temp_y
D=M
@SIGN_Y_NEGATIVE    // Jump if y is negative
D;JLT
@sign_y
M=1                 // y is positive, sign = 1
@COMPARE_SIGNS
0;JMP
(SIGN_Y_NEGATIVE)
@sign_y
M=-1                // y is negative, sign = -1

// Compare signs to determine the quotient's final sign
(COMPARE_SIGNS)
@sign_x
D=M
@sign_y
D=D-M               // Check if signs are the same
@SAME_SIGNS         // Jump if signs match
D;JEQ
@sign_m
M=-1                // Signs differ, quotient is negative
@ADJUST_M
0;JMP
(SAME_SIGNS)
@sign_m
M=1                 // Signs match, quotient is positive

// Adjust quotient's sign and store in R2
(ADJUST_M)
@sign_m
D=M
@ADJUST_M_NEG       // Jump if quotient should be negative
D;JLT
@m_unsigned
D=M
@R2
M=D                 // Store positive quotient in R2
@ADJUST_Q
0;JMP
(ADJUST_M_NEG)
@m_unsigned
D=M
@R2
M=-D                // Store negative quotient in R2

// Adjust remainder's sign to match x and store in R3
(ADJUST_Q)
@sign_x
D=M
@ADJUST_Q_NEG       // Jump if x was negative
D;JLT
@rem
D=M
@R3
M=D                 // Store positive remainder in R3
@SET_R4
0;JMP
(ADJUST_Q_NEG)
@rem
D=M
@R3
M=-D                // Store negative remainder in R3

// Set valid division flag (R4=0)
(SET_R4)
@R4
M=0                 // Division is valid
@END
0;JMP

// Handle invalid division (divisor is zero)
(INVALID_DIVISION)
@R4
M=1                 // Set flag to 1 for invalid division

// Program termination
(END)
@END
0;JMP               // Infinite loop to halt execution
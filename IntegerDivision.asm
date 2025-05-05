// IntegerDivision.asm
// ====================
// Computes signed integer quotient (R2) and remainder (R3)
// Flag R4=1 if division is invalid (divisor=0)

// Phase 1: Input Validation
// -------------------------
    @R1
    D=M
    @DIV_BY_ZERO      // Jump to error handler if divisor=0
    D;JEQ

// Phase 2: Absolute Value Conversion
// ----------------------------------
// Convert x (R0) and y (R1) to absolute values
    @R0
    D=M
    @x_abs
    M=D               // Initialize x_abs with R0
    @CONVERT_Y        // Skip negation if x >=0
    D;JGE
    @x_abs
    M=-D              // Take absolute value if x negative

(CONVERT_Y)
    @R1
    D=M
    @y_abs
    M=D               // Initialize y_abs with R1
    @DIV_LOOP_INIT    // Skip negation if y >=0
    D;JGE
    @y_abs
    M=-D              // Take absolute value if y negative

// Phase 3: Unsigned Division Core
// -------------------------------
(DIV_LOOP_INIT)
    @x_abs
    D=M
    @remainder
    M=D               // remainder = |x|
    @quotient
    M=0               // quotient = 0

(DIV_LOOP)
    @remainder
    D=M
    @y_abs
    D=D-M             // Calculate remainder - |y|
    @SIGN_ADJUST      // Exit loop when remainder < |y|
    D;JLT

    @y_abs
    D=M
    @remainder
    M=M-D             // Subtract |y| from remainder
    @quotient
    M=M+1             // Increment quotient
    @DIV_LOOP
    0;JMP             // Repeat division

// Phase 4: Sign Adjustment
// ------------------------
(SIGN_ADJUST)
// Determine quotient sign
    @R0
    D=M
    @R1
    D=D^M             // XOR signs of x and y
    @Q_POSITIVE
    D;JGE             // Same signs -> positive quotient
    @quotient
    M=-M              // Different signs -> negative quotient
(Q_POSITIVE)

// Adjust remainder sign to match x
    @R0
    D=M
    @R3
    M=0               // Clear R3
    @remainder
    D=M
    @R_POSITIVE
    D;JGE             // Remainder is already positive
    @remainder
    M=-M              // Take absolute value of remainder
(R_POSITIVE)
    @R0
    D=M               // Check original x sign
    @STORE_RESULT
    D;JGE
    @remainder
    M=-M              // Flip remainder if x was negative

// Phase 5: Final Storage
// ----------------------
(STORE_RESULT)
    @quotient
    D=M
    @R2
    M=D               // Store final quotient
    @remainder
    D=M
    @R3
    M=D               // Store final remainder
    @R4
    M=0               // Mark division as valid
    @END
    0;JMP

// Error Handler
// -------------
(DIV_BY_ZERO)
    @R4
    M=1               // Set invalid division flag

// Program Termination
// -------------------
(END)
    @END
    0;JMP             // Infinite termination loop
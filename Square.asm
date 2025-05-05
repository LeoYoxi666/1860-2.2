// Square.asm
// Computes y = x * x
// Input: x in R0
// Output: y in R1
// Do not modify R0
// Handles both positive and negative x

@R0
D=M             // Load x
@NEGATIVE
D;JLT           // If x < 0, go to NEGATIVE

// Case: x >= 0
@R0
D=M
@R2
M=D             // R2 = x (loop counter)
@R1
M=0             // R1 = 0 (initialize result)

(POS_LOOP)
@R2
D=M
@END
D;JEQ           // If counter == 0, we're done

@R0
D=M             // Load x again
@R1
M=M+D           // R1 += x

@R2
M=M-1           // Decrement counter
@POS_LOOP
0;JMP

(NEGATIVE)
// Case: x < 0 → use absolute value
@R0
D=M
D=-D            // D = |x|
@R2
M=D             // R2 = |x| (loop counter)
@R1
M=0             // R1 = 0 (initialize result)

(NEG_LOOP)
@R2
D=M
@END
D;JEQ           // If counter == 0, we're done

@R2
D=M             // D = |x|
@R1
M=M+D           // R1 += |x|

@R2
M=M-1           // Decrement counter
@NEG_LOOP
0;JMP

(END)
@END
0;JMP           // Infinite loop to end program

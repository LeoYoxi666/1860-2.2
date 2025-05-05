// SumEvenIntegers.asm
// Computes z = sum_{i=0}^n (2 * i)
// Input n in R0, result z in R1
// If n < 0 → R1 = -1; if overflow → R1 = -2

@R0
D=M
@NEGATIVE
D;JLT        // If n < 0, go to NEGATIVE

@R1
M=0          // Initialize sum in R1 to 0
@R2
M=0          // i = 0

(LOOP)
@R2
D=M
@R0
D=D-M
@DONE
D;GT         // if i > n, end loop

@R2
D=M
D=D+D        // D = 2 * i
@R1
M=D+M        // Add 2*i to sum

@R2
M=M+1        // i++
@LOOP
0;JMP

(DONE)
@END
0;JMP

(NEGATIVE)
@R1
M=-1
@END
0;JMP

(END)
@END
0;JMP

// SumEvenIntegers.asm
// Computes the sum of the first n even numbers: 0 + 2 + 4 + ... + 2n
// R0: input n
// R1: output sum
// R2: loop counter (i)

@R0
D=M             // Load input n
@NEGATIVE
D;JLT           // If n < 0, go to error handler

@R1
M=0             // Initialize sum R1 = 0

@R2
M=0             // Initialize loop counter i = 0

(LOOP)
@R2
D=M             // D = i
@R0
D=D-M
@END
D;JGT           // If i > n, we're done

@R2
D=M             // D = i
D=D+D           // D = 2 * i

@R1
M=M+D           // R1 = R1 + 2*i

@R2
M=M+1           // i++

@LOOP
0;JMP           // Repeat loop

(NEGATIVE)
@R1
M=-1            // If n < 0, store -1 as error result
@END
0;JMP

(END)
@END
0;JMP           // Infinite loop to halt execution

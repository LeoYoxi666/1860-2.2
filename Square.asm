// Square.asm
// Compute y = x^2, where x is initially stored in R0
// Store the result in R1 without modifying R0

@R0
D=M         // Load the value of R0 into D register

@R1
M=0         // Initialize R1 to 0

@i
M=D         // Initialize i (loop counter) with the value of R0

(LOOP)
@i
D=M         // Load the value of i into D register

@END
D;JEQ       // If i == 0, jump to END

@R1
D=M         // Load the value of R1 into D register

@R0
D=D+M       // Add the value of R0 to D register

@R1
M=D         // Store the result back in R1

@i
M=M-1       // Decrement i by 1

@LOOP
0;JMP       // Jump back to LOOP

(END)
@END
0;JMP       // Infinite loop to end the program
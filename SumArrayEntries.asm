// SumArrayEntries.asm (Alternate Style)
// Sums all entries in an array
// Inputs:
//   R0 = base address of array
//   R1 = number of entries to sum
// Output:
//   R2 = total sum of array entries
// Internals:
//   R3 = current address pointer
//   R4 = remaining counter

@R1
D=M             // Load number of entries
@INVALID_INPUT
D;JLE           // If count <= 0, go to set result = 0

// ---- Initialization ----

@R0
D=M
@R3
M=D             // R3 = base address (array pointer)

@R1
D=M
@R4
M=D             // R4 = number of entries remaining

@R2
M=0             // R2 = 0 (initialize sum)

// ---- Loop: while R4 > 0 ----

(SUM_LOOP)
@R4
D=M
@FINISH
D;JEQ           // If no more entries, end

@R3
A=M             // A = current array address
D=M             // D = *R3 = current array value

@R2
M=M+D           // R2 += value at current address

@R3
M=M+1           // Move pointer to next address

@R4
M=M-1           // Decrease remaining counter

@SUM_LOOP
0;JMP           // Repeat loop

// ---- Handle invalid or empty input ----
(INVALID_INPUT)
@R2
M=0             // If input count invalid, result is 0

(FINISH)
@FINISH
0;JMP           // Halt program

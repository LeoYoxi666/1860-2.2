// IntegerDivision.asm
// 计算 x // y 和 x % y，x 存 R0，y 存 R1，m 存 R2，q 存 R3，flag 存 R4

@R1
D=M
@INVALID
D;JEQ       // 如果 y = 0，则跳转到 INVALID

@R2
M=0         // m = 0
@R3
M=0         // q = 0

(LOOP)
    @R0
    D=M
    @R3
    D=D-M   // 计算 x - q

    @R1
    D=D-M
    @END
    D;JLT   // 如果 x - q - y < 0，跳出循环

    @R2
    M=M+1   // m++

    @R3
    @R1
    D=M
    @R3
    M=M+D   // q += y

    @LOOP
    0;JMP   // 继续循环

(INVALID)
    @R4
    M=1
    @END
    0;JMP

(END)
    @R4
    M=0
    @END
    0;JMP

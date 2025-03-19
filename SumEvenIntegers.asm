// SumEvenIntegers.asm
// 计算前 n 个偶数和，n 存储在 R0，结果存入 R1

@R0
D=M
@NEGATIVE
D;JLT        // 如果 n < 0, 跳转到 NEGATIVE

@R1
M=0          // 初始化 R1 = 0
@R2
M=0          // 初始化计数 i = 0

(LOOP)
    @R2
    D=M
    @R0
    D=D-M
    @END
    D;JGT    // 如果 i > n, 结束

    @R2
    D=M
    D=D+M    // 计算 2 * i
    @R1
    M=M+D    // 累加到 R1
    
    @R2
    M=M+1    // i++

    @LOOP
    0;JMP    // 继续循环

(NEGATIVE)
    @R1
    M=-1
    @END
    0;JMP

(END)
    @END
    0;JMP

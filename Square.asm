// Square.asm
// 计算 y = x^2, x 存储在 R0，结果存入 R1，不修改 R0

@R0
D=M        // D = x
@R1
M=0        // R1 = 0 (初始化 y)

(LOOP)
    @D
    D=D-1  // D = D - 1 (减少 x)
    @END
    D;JLT  // 如果 x < 0，跳出循环

    @R0
    D=M    // D = x
    @R1
    M=M+D  // R1 += x (累加 x)
    
    @LOOP
    0;JMP  // 继续循环

(END)
    @END
    0;JMP  // 进入死循环

// IntegerDivision.asm
// 输入: R0 = x (被除数), R1 = y (除数)
// 输出: R2 = m (商), R3 = q (余数), R4 = flag (错误标志, 1=错误, 0=正常)

    @R1
    D=M          // D = y
    @DIV_ERROR   // 如果 y == 0，则跳转到错误处理
    D;JEQ

    // 初始化
    @R0
    D=M          // D = x
    @R2
    M=0          // m (商) 设为 0
    @R3
    M=D          // q (余数) 初始化为 x
    @R4
    M=0          // flag 设为 0 (假设无错误)

    // 处理符号
    @R0
    D=M
    @NEG_X
    D;JLT        // 如果 x < 0，跳转 NEG_X

    @R1
    D=M
    @NEG_Y
    D;JLT        // 如果 y < 0，跳转 NEG_Y

    // x 和 y 都是正数，直接执行除法
(LOOP)
    @R3
    D=M
    @R1
    D=D-M        // D = q - y
    @END
    D;JLT        // 如果 q < y，则跳转 END

    @R3
    M=D          // 更新余数 q
    @R2
    M=M+1        // 商 +1
    @LOOP
    0;JMP        // 继续循环

(END)
    @R0
    D=M
    @R1
    D=D*M        // 计算符号 (x*y)
    @POSITIVE
    D;JGE        // 如果 x*y >= 0, 直接结束

    // 取反商，使得商的符号与 x 一致
    @R2
    M=-M

(POSITIVE)
    @HALT
    0;JMP

// 处理错误情况
(DIV_ERROR)
    @R4
    M=1          // 设错误标志
    @HALT
    0;JMP

(HALT)
    @HALT
    0;JMP        // 无限循环

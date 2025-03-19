// IntegerDivision.asm
// 计算 R0 / R1，结果存入 R2（商）和 R3（余数）
// 若除法无效 (R1 = 0)，则 R4 = 1，否则 R4 = 0

    @R1
    D=M       // D = R1 (除数)
    @INVALID
    D;JEQ     // 如果 R1 == 0，则跳转到 INVALID 处理

    @R0
    D=M       // D = R0 (被除数)
    @R2
    M=0       // 初始化商 R2 = 0
    @R3
    M=D       // 初始化余数 R3 = R0

    // 取 R0 和 R1 的符号
    @R0
    D=M
    @SIGN_X
    M=D       // SIGN_X = R0 (存储被除数的符号)
    @R1
    D=M
    @SIGN_Y
    M=D       // SIGN_Y = R1 (存储除数的符号)

    // 取绝对值 R0 = |R0|
    @R0
    D=M
    @POSITIVE_X
    D;JGE     // 如果 R0 >= 0，跳过取反
    @R3
    M=-M      // R3 = -R3 (取绝对值)
(POSITIVE_X)

    // 取绝对值 R1 = |R1|
    @R1
    D=M
    @POSITIVE_Y
    D;JGE     // 如果 R1 >= 0，跳过取反
    @R1
    M=-M      // R1 = -R1 (取绝对值)
(POSITIVE_Y)

    // 执行除法：R3 (余数) 逐步减去 R1 直到不足以再减
(DIV_LOOP)
    @R3
    D=M
    @R1
    D=D-M
    @END_DIV
    D;JL      // 如果余数小于 R1，则结束

    @R3
    M=D       // 更新余数 R3
    @R2
    M=M+1     // 商 R2 += 1
    @DIV_LOOP
    0;JMP     // 继续循环

(END_DIV)
    // 计算商的符号
    @SIGN_X
    D=M
    @SIGN_Y
    D=D*M     // 如果 x 和 y 符号相同，D >= 0，否则 D < 0
    @POSITIVE_QUOTIENT
    D;JGE     // 如果符号相同，跳过取反
    @R2
    M=-M      // 商取反
(POSITIVE_QUOTIENT)

    // 恢复余数的符号，使其与 R0 相同
    @SIGN_X
    D=M
    @POSITIVE_REMAINDER
    D;JGE     // 如果 R0 >= 0，跳过取反
    @R3
    M=-M      // 余数取反
(POSITIVE_REMAINDER)

    // 设置有效标志 R4 = 0
    @R4
    M=0
    @END
    0;JMP

(INVALID)
    @R4
    M=1       // 除法无效时，R4 设为 1
(END)

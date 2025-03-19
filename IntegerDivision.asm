// IntegerDivision.asm
// 计算 x / y，其中 x 存在 R0，y 存在 R1
// 商 (m) 存在 R2, 余数 (q) 存在 R3
// R4 作为无效标志 (y = 0 时设为 1，否则设为 0)

@R1
D=M
@DIV_ZERO
D;JEQ      // 如果 y == 0，跳转到 DIV_ZERO

@R4
M=0        // 设 R4 = 0 (有效除法)
@R2
M=0        // 设 R2 (m) = 0
@R3
M=0        // 设 R3 (q) = 0
@R0
D=M
@TEMP
M=D        // TEMP = x (备份 x)

(LOOP)
@TEMP
D=M
@R1
D=D-M
@END_LOOP
D;JLT      // 如果 x < y，结束

@R2
M=M+1      // m++
@TEMP
M=M-D      // x = x - y (模拟减法除法)
@LOOP
0;JMP      // 继续循环

(END_LOOP)
@R3
M=M+D      // 余数 q = x

@END
0;JMP

(DIV_ZERO)
@R4
M=1        // 设 R4 = 1 (无效除法)
@END
0;JMP

(END)
@END
0;JMP



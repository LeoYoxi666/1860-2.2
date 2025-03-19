// Square.asm
// 计算 y = x^2, x 存在 R0，y 存在 R1

@R1
M=0        // R1 (y) 初始化为 0
@R0
D=M        // D = x
@IS_ZERO
D;JEQ      // 如果 x == 0，直接结束

@R2
M=D        // R2 = x (作为计数器)
@LOOP
D=M        // D = 计数器值
@END
D;JEQ      // 如果计数器归零，结束

@R1
D=M
@R0
D=D+M      // D = y + x
@R1
M=D        // 更新 y = y + x

@R2
M=M-1      // 计数器--
@LOOP
0;JMP      // 继续循环

(IS_ZERO)
@R1
M=0        // x = 0 时，y 也设为 0
@END
0;JMP

(END)
@END
0;JMP


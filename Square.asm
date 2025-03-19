// Square.asm
// 计算 y = x²，x 存储在 R0 中，结果存储在 R1 中

@R0
D=M
@NEGATIVE
D;JLT        // 如果 x < 0，跳转到负数处理

@R0
D=M
@R2
M=D          // R2 = x (非负数时直接使用)
@R1
M=0          // 初始化结果 R1 = 0

(LOOP)
@R2
D=M
@END
D;JEQ        // 如果计数器 R2 == 0，结束循环

@R0
D=M          // 累加原始值 x（非负数分支）
@R1
M=D+M        // R1 += x
@R2
M=M-1        // 计数器 R2 -= 1
@LOOP
0;JMP

(NEGATIVE)
@R0
D=M
@R2
M=-D         // R2 = |x| (负数取绝对值)
@R1
M=0          // 初始化结果 R1 = 0

(LOOP_NEG)
@R2
D=M
@END
D;JEQ        // 如果计数器 R2 == 0，结束循环

@R2
D=M          // 累加绝对值 |x|
@R1
M=D+M        // R1 += |x|
@R2
M=M-1        // 计数器 R2 -= 1
@LOOP_NEG
0;JMP

(END)
@END
0;JMP        // 程序终止
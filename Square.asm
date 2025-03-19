// Square.asm
@R0
D=M      // D = x
@R1
M=0      // R1 = 0 (初始化 y=0)
@R2
M=D      // R2 = x (循环计数器)

(LOOP)
@R2
D=M
@END
D;JEQ    // 如果 R2 == 0，结束循环

@R0
D=M      // D = x
@R1
M=M+D    // y += x

@R2
M=M-1    // R2 -= 1
@LOOP
0;JMP    // 继续循环

(END)
@END
0;JMP    // 结束程序

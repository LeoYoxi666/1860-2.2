// SumArrayEntries.asm
@R1
D=M
@ZERO_RESULT
D;JLE    // 如果 R1 <= 0，跳转到 ZERO_RESULT

@R2
M=0      // 结果初始化为 0
@R3
M=0      // 计数器 i = 0

(LOOP)
@R3
D=M
@R1
D=D-M
@END
D;JGE    // 如果 i >= R1，结束

@R0
D=M
@R3
A=D+M    // 访问数组的 R3 索引位置
D=M
@R2
M=M+D    // 累加到 R2

@R3
M=M+1    // i++
@LOOP
0;JMP    // 继续循环

(ZERO_RESULT)
@R2
M=0
@END
0;JMP

(END)
@END
0;JMP

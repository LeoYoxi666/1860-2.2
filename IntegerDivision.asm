// IntegerDivision.asm
@R1
D=M
@DIV_ZERO
D;JEQ    // 如果 y == 0，跳转到 DIV_ZERO

@R4
M=0      // 除法有效，标志位设为 0
@R2
M=0      // m = 0 (商)
@R3
M=0      // q = 0 (余数)
@R0
D=M      // D = x

(LOOP)
D=M
@R1
D=D-M
@END_LOOP
D;JLT    // 如果 x < y，结束

@R2
M=M+1    // m++
@R0
D=M
@R1
D=D-M    // x = x - y
@R0
M=D      // 更新 x
@LOOP
0;JMP    // 继续循环

(END_LOOP)
@R3
M=D      // 余数 q = x

@END
0;JMP

(DIV_ZERO)
@R4
M=1      // 除法无效
@END
0;JMP


addi x12,x0, 50
slli x12,x12,2
addi x10,x0,30
sw x10, 0(x0)
lw x17, 0(x0)
bge x12,x17, label
addi x14,x0,50
jal  x0,exit
label:add x13,x12,x10
exit:
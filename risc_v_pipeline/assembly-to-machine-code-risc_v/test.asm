addi x12,x0,30
addi x10,x0,30
sw x10, 0(x0)
lw x17, 0(x0)
jal x0,label
addi x14,x0,50
label:add x13,x12,x10
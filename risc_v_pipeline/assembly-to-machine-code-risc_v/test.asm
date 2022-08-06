addi x10,x0,5
addi x12,x0,0
addi  x11,x10,10
sw    x11, 0(x12)
lw    x13, 0(x12)
add   x14, x13, x10

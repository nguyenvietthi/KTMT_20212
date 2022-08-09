# bubble sort 

addi x5, x0, 4                            #x3 base address
addi x12, x0, -50
sw   x12, 0(x5)
addi x12, x0, 30
sw   x12, 4(x5)
addi x12, x0, 70
sw   x12, 8(x5)
addi x12, x0, 1
sw   x12, 12(x5)
addi x12, x0, 3
sw   x12, 16(x5)
addi x12, x0, 56
sw   x12, 20(x5)
addi x12, x0, 12
sw   x12, 24(x5)
addi x12, x0, -85
sw   x12, 28(x5)
addi x12, x0, -1
sw   x12, 32(x5)
addi x12, x0, 17
sw   x12, 36(x5)
addi x12, x0, 18
sw   x12, 40(x5)
addi x12, x0, -47
sw   x12, 44(x5)
addi x12, x0, 78
sw   x12, 48(x5)


addi x1, x0, 0 

addi x2, x0, 11 

outer_loop_start:
  add x10, x0, x5
  lw x7, 0(x10)
  sub x11, x2, x1 # Inner loop count: outer loop count - sorted elements                  
inner_loop_start:
  lw x4, 4(x10)
  blt x7,x4, noswap

  sw x4, 0(x10)
  sw x7, 4(x10)
noswap:

  slt x6, x7, x4

  beq x6, x0, skip

  add x7, x4, x0
skip:

  addi x10, x10, 4  #Increment the address to next element

  addi x11, x11, -1

  bne x11, x0, inner_loop_start

inner_loop_end:

addi x1, x1, 1

blt x1, x2, outer_loop_start

outer_loop_end:

.data
arr: .word 1,2,4096,16,256

.text
main:
        #get base address
        la x8, arr
        #init i
        add x15, x0, x0
        #for loop i
L1:
        #init min_id
        add x16, x0, x15
        #init j
        addi x6, x15, 1
        #for loop j
L2:
        slli x7, x6, 2
        slli x28, x16, 2
        add x5, x8, x28
        lw x31, 0(x5)
        add x5, x8, x7
        lw x30, 0(x5)
        bge x30, x31, nochange
        add x16, x0, x6
nochange:
        addi x6, x6, 1
        addi x9, x0, 5
        blt x6, x9, L2
swap:
        #get a[i] 
        slli x29, x15, 2
        add x5, x29, x8
        #load a[i] in x30
        lw x30, 0(x5)
        #get a[min_id]
        slli x28, x16, 2
        add x5, x28, x8
        #load a{min_id] in x31
        lw x31, 0(x5)
        #put a[min_id] in a[i]
        add x5, x29, x8
        sw x31, 0(x5)
        #get a[min_id]
        add x5, x28, x8
        sw x30, 0(x5)
        addi x1, x0, 4
        addi x15, x15, 1
        blt x15, x1, L1
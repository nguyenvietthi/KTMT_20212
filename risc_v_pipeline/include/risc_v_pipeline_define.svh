`ifndef GLOBAL_DEFINE
`define GLOBAL_DEFINE
  //Immediate selection
  `define ImmSelI  3'b000
  `define ImmSelS  3'b001
  `define ImmSelB  3'b010
  `define ImmSelJ  3'b011
  `define ImmSelU  3'b100
  `define ImmSelR  3'b111
  
  //ALU operation
  `define ALUadd  4'b0000
  `define ALUsub  4'b0001
  `define ALUsll  4'b0010
  `define ALUslt  4'b0011
  `define ALUsltu 4'b0100
  `define ALUxor  4'b0101
  `define ALUsrl  4'b0110
  `define ALUsra  4'b0111
  `define ALUor   4'b1000
  `define ALUand  4'b1001
  `define ALUnop  4'b1111

  //Instrucion type
  `define NoP    7'b0000000
  `define R      7'b0110011
  `define IMM_I  7'b0010011
  `define LOAD_I 7'b0000011
  `define S      7'b0100011
  `define B      7'b1100011
  `define JUMP_I 7'b1100111
  `define J      7'b1101111
  `define U      7'b0010111
  
`endif
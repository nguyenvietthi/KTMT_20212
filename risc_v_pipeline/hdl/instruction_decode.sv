module instruction_decode (
  input                   clk     ,
  input                   rst_n   ,
  input  [32:0]           inst_i  ,
  output [4:0]            rd_o    ,
  output [4:0]            rs1_o   ,
  output [4:0]            rs2_o   ,
  output [2:0]            funct3_o,
  output [6:0]            funct7_o           

);
  assign opcode   = inst_i[6:0]  ;
  assign rd_o     = inst_i[11:7] ;
  assign rs1_o    = inst_i[19:15]; 
  assign rs2_o    = inst_i[24:20]; 
  assign funct3_o = inst_i[14:12];
  assign funct7_o = inst_i[31:25];

endmodule
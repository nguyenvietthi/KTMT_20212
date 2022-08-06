`include "risc_v_pipeline_define.svh"
module instruction_decode (
  input  [31:0] inst_i  ,
  output [4:0]  rd_o    ,
  output [4:0]  rs1_o   ,
  output [4:0]  rs2_o   ,
  output [2:0]  funct3_o,
  output [6:0]  funct7_o,          
  output [6:0]  opcode_o          
);

  assign opcode_o = inst_i[6:0];
  assign rd_o     = ((opcode_o != `S) || (opcode_o != `B))                     ? inst_i[11:7]  : 0;
  assign rs1_o    = ((opcode_o != `J) || (opcode_o != `U))                     ? inst_i[19:15] : 0;
  assign rs2_o    = ((opcode_o == `R) || (opcode_o == `B) || (opcode_o == `S)) ? inst_i[24:20] : 0; 
  assign funct3_o = ((opcode_o != `J) || (opcode_o != `U))                     ? inst_i[14:12] : 0;
  assign funct7_o =  (opcode_o == `R)                                          ? inst_i[31:25] : 0;

endmodule
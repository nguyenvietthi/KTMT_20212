`include "risc_v_pipeline_define.svh"
module imm_gen (
  input      [31:0] inst_i   ,
  input      [2:0]  imm_sel_i,
  output reg [31:0] imm_o           
);
  always @(*) begin
    case (imm_sel_i)
      //I-Type
      `ImmSelI: imm_o = {{20{inst_i[31]}},inst_i[31:20]};
      //S-Type
      `ImmSelS: imm_o = {{20{inst_i[31]}},inst_i[31:25], inst_i[11:7]};
      //B-Type
      `ImmSelB: imm_o = {{20{inst_i[31]}}, inst_i[7], inst_i[30:25], inst_i[11:8], 1'b0};
      //J-Type
      `ImmSelJ: imm_o = {{12{inst_i[31]}}, inst_i[19:12], inst_i[20], inst_i[30:21], 1'b0};
      //U-Type
      `ImmSelU: imm_o = {inst_i[31:12],12'b0};
      
      default : imm_o = 32'b0;
    endcase
  end
endmodule
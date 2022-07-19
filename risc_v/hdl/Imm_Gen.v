module Imm_Gen (
//  input            clk        ,// Clock
//  input            rst_n      ,// Asynchronous reset active low
  input     [31:0] inst       ,
  input     [2:0]  ImmSel     ,
  output reg[31:0] imm         
);
  always @(*) begin : proc_imm
    case (ImmSel)
      //I-Type
      3'b000: imm = {{20{inst[31]}},inst[31:20]};
      //S-Type
      3'b001: imm = {{20{inst[31]}},inst[31:25], inst[11:7]};
      //B-Type
      3'b010: imm = {{20{inst[31]}}, inst[7], inst[30:25], inst[11:8], 1'b0};
      //J-Type
      3'b011: imm = {{12{inst[31]}}, inst[19:12], inst[20], inst[30:21], 1'b0};
      //U-Type
      3'b100: imm = {inst[31:12],12'b0};
      default : imm = 32'b0;
    endcase
  end
endmodule
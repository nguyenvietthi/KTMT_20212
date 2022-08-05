`include "risc_v_pipeline_define.svh"
module ALU(
  input  [31:0]     src1      ,  //src1
  input  [31:0]     src2      ,  //src2
  input  [3:0]      ALU_sel   , //function sel
  output reg [31:0] alu_result,  //alu_result 
  output            zero_flag      
);

  assign zero_flag = (alu_result == 32'd0) ? 1'b1: 1'b0;

  always @(*) begin 
    case(ALU_sel)
      `ALUadd : alu_result = src1 + src2; // add

      `ALUsub : alu_result = src1 - src2; // sub

      `ALUsll : alu_result = src1 << src2[4:0];

      `ALUslt : alu_result = $signed(src1) < $signed(src2);

      `ALUsltu: alu_result = src1 < src2;

      `ALUxor : alu_result = src1 ^ src2;

      `ALUsrl : alu_result = src1 >> src2[4:0];

      `ALUsra : alu_result = ({32{src1[31]}} << {6'd32 - {1'b0, src1[4:0]}}) |
                (src1 >> src2[4:0]);

      `ALUor  : alu_result = src1 | src2;

      `ALUand : alu_result = src1 & src2;

      `ALUnop : alu_result = 0;

      default: alu_result = 0; //NoP
    endcase
  end
endmodule
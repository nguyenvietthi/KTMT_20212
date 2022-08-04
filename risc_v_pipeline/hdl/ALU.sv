module ALU(
  input  [31:0]     src1      ,  //src1
  input  [31:0]     src2      ,  //src2
  input  [3:0]      ALU_sel   , //function sel
  output reg [31:0] alu_result,  //alu_result 
  output            zero_flag      
);
  parameter ALUadd  =  4'b0000;
  parameter ALUsub  =  4'b0001;
  parameter ALUsll  =  4'b0010;
  parameter ALUslt  =  4'b0011;
  parameter ALUsltu =  4'b0100;
  parameter ALUxor  =  4'b0101;
  parameter ALUsrl  =  4'b0110;
  parameter ALUsra  =  4'b0111;
  parameter ALUor   =  4'b1000;
  parameter ALUand  =  4'b1001;
  parameter ALUnop  =  4'b1111;

  assign zero_flag = (alu_result == 32'd0) ? 1'b1: 1'b0;

  always @(*) begin 
    case(ALU_sel)
      ALUadd : alu_result = src1 + src2; // add

      ALUsub : alu_result = src1 - src2; // sub

      ALUsll : alu_result = src1 << src2[4:0];

      ALUslt : alu_result = $signed(src1) < $signed(src2);

      ALUsltu: alu_result = src1 < src2;

      ALUxor : alu_result = src1 ^ src2;

      ALUsrl : alu_result = src1 >> src2[4:0];

      ALUsra : alu_result = ({32{src1[31]}} << {6'd32 - {1'b0, src1[4:0]}}) |
                (src1 >> src2[4:0]);

      ALUor  : alu_result = src1 | src2;

      ALUand : alu_result = src1 & src2;

      ALUnop : alu_result = 0;

      default:alu_result = 0; //NoP
    endcase
  end
endmodule
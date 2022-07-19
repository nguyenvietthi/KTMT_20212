module mux4_1 #(parameter BIT_WIDTH = 32)
(
  input      [1:0]           sel,
  input      [BIT_WIDTH-1:0] in0,
  input      [BIT_WIDTH-1:0] in1,
  input      [BIT_WIDTH-1:0] in2,
  input      [BIT_WIDTH-1:0] in3,
  output reg [BIT_WIDTH-1:0] out 
);
always @(*) begin
  case (sel)
    2'b00: out = in0;
    2'b01: out = in1;
    2'b10: out = in2;
    2'b11: out = in3;
    default : out = 0;
  endcase
end
endmodule
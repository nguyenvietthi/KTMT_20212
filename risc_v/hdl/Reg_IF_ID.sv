module Reg_IF_ID (
  input  wire        clk    ,
  input  wire        rst_n  ,
  input  wire [31:0] if_pc  ,
  input  wire [31:0] if_inst,
  output reg  [31:0] id_pc  ,
  output reg  [31:0] id_inst 
);
  always @ (posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      id_pc   <= 0;
      id_inst <= 0;
    end else begin
      id_pc   <= if_pc;
      id_inst <= if_inst;
    end
  end
endmodule // reg_if_id
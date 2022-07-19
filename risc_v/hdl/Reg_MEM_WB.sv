module Reg_MEM_WB (
  //Input from EX
  input  wire        clk        ,
  input  wire        rst_n      ,
  input  wire        mem_RegWEn ,
  input  wire [4:0]  mem_rd     ,
  input  wire [31:0] mem_pc     ,
  input  wire [31:0] mem_imm    ,
  input  wire [31:0] mem_DataB  ,
  input  wire [31:0] mem_ALU_out,
  input  wire [31:0] mem_WBData ,
  output reg         wb_RegWEn  ,
  output reg  [31:0] wb_WBData  ,
  output reg  [4:0]  wb_rd      ,//To Forwarding Unit
  output reg  [31:0] wb_ALU_out ,//To MUX
  output reg  [31:0] wb_DataB   ,//To MUX
  output reg  [31:0] wb_pc      ,
  output reg  [31:0] wb_imm     
);

  always @ (posedge clk) begin
    if (!rst_n) begin
      wb_WBData   <= 0;
      wb_RegWEn   <= 0;
      wb_pc       <= 0;
      wb_ALU_out  <= 0;
      wb_DataB    <= 0;
      wb_imm      <= 0;
      wb_rd       <= 0;
    end
    else begin
      wb_WBData   <= mem_WBData ;
      wb_RegWEn   <= mem_RegWEn ;
      wb_pc       <= mem_pc     ;
      wb_ALU_out  <= mem_ALU_out;
      wb_DataB    <= mem_DataB  ;
      wb_imm      <= mem_imm    ;
      wb_rd       <= mem_rd     ;
    end
  end

endmodule // reg_if_ex
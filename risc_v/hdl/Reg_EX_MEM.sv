module Reg_EX_MEM (
  //Input from EX
  input  wire        clk        ,
  input  wire        rst_n      ,
  input  wire        ex_MemRW   ,
  input  wire        ex_RegWEn  ,
  input  wire [4:0]  ex_rd      ,
  input  wire [31:0] ex_pc      ,
  input  wire [31:0] ex_imm     ,
  input  wire [31:0] ex_DataB   ,
  input  wire [31:0] ex_ALU_out ,
  input  wire [1:0]  ex_WBSel   ,
  input  wire [4:0]  ex_rs2     ,
  //Output to MEM                
  output reg         mem_RegWEn ,
  output reg         mem_MemRW  ,
  output reg  [1:0]  mem_WBSel  ,
  output reg  [31:0] mem_imm    ,
  output reg  [4:0]  mem_rd     ,
  output reg  [4:0]  mem_rs2    ,
  output reg  [31:0] mem_ALU_out,
  output reg  [31:0] mem_DataB  ,
  output reg  [31:0] mem_pc      
);

  always @ (posedge clk) begin
    if (!rst_n) begin
      mem_RegWEn   <= 0;
      mem_pc       <= 0;
      mem_ALU_out  <= 0;
      mem_DataB    <= 0;
      mem_imm      <= 0;
      mem_MemRW    <= 0;
      mem_rd       <= 0;
      mem_WBSel    <= 0;
      mem_rs2      <= 0;
    end else if (1) begin
      mem_RegWEn   <= ex_RegWEn ;
      mem_pc       <= ex_pc     ;
      mem_ALU_out  <= ex_ALU_out;
      mem_DataB    <= ex_DataB  ;
      mem_imm      <= ex_imm    ;
      mem_MemRW    <= ex_MemRW  ;
      mem_rd       <= ex_rd     ;
      mem_WBSel    <= ex_WBSel  ;
      mem_rs2      <= ex_rs2    ;
    end
  end

endmodule // reg_if_ex
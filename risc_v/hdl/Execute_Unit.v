module Execute_Unit(
  input        clk        ,
  input        rst_n      ,
  input        id_BrUn    ,
  input        id_ASel    ,
  input        id_BSel    ,
  input [31:0] ex_pc      ,
  input [31:0] mem_ALU_out,
  input [1:0]  ForwardASel,//From Forwarding Unit
  input [1:0]  ForwardBSel,//From Forwarding Unit
  input [31:0] ex_DataA   ,
  input [31:0] ex_DataB   ,
  input [31:0] imm        ,
  input [31:0] wb_WBData  ,
///  input [1:0]  ex_WBSel   ,
  input [3:0]  ex_ALUSel      ,
  output[31:0] ex_ALU_out     ,
  output       ex_BrEq        ,
  output       ex_BrLT        ,
  output[31:0] ex_ForwardDataB 
);
  wire [31:0] ALU_DataA   ;
  wire [31:0] ALU_DataB   ;
  wire [31:0] ForwardDataA;
  wire [31:0] ForwardDataB;
  wire zero_flag;
  assign ex_ForwardDataB = ForwardDataB;
  assign ALU_DataA = id_ASel ? ex_pc : ForwardDataA;
  assign ALU_DataB = id_BSel ? imm   : ForwardDataB;
//=========================INSTANCE=========================//
//
  mux4_1 ForwardA_mux
  (
  .sel(ForwardASel ),
  .in0(ex_DataA    ),
  .in1(wb_WBData   ),
  .in2(mem_ALU_out ),
  .in3(            ),
  .out(ForwardDataA) 
  );
//
  mux4_1 ForwardB_mux
  (
  .sel(ForwardBSel ),
  .in0(ex_DataB    ),
  .in1(wb_WBData   ),
  .in2(mem_ALU_out ),
  .in3(            ),
  .out(ForwardDataB) 
  );
//Branch Comparator
  Branch_Comparator Branch_Comparator_i
  (
  .BrUn       (id_BrUn    ),
  .ex_DataA   (ex_DataA   ),
  .ex_DataB   (ex_DataB   ),
  .BrEq       (ex_BrEq    ),
  .BrLt       (ex_BrLt    ) 
  );
//ALU
  ALU ALU_Unit
  (
  .a          (ALU_DataA   ),
  .b          (ALU_DataB   ),
  .ALUSel     (ex_ALUSel   ),
  .alu_result (ex_ALU_out  ),
  .zero_flag  (zero_flag   ) 
  );
endmodule
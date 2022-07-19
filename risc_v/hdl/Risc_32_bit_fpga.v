module Risc_32_bit_fpga
(
  input        clk            ,
  input        rst_n          ,
  input  [31:0]DataB_out      ,
  input  [31:0]if_inst        ,
  input  [31:0]if_pc          ,
  output [31:0]mem_ALU_out    ,
  output [31:0]ex_ForwardDataB,
  output       mem_MemRW      ,
  output [31:0]pc_next         

);
  parameter ImmSelI = 3'b000;
  parameter ImmSelS = 3'b001;
  parameter ImmSelB = 3'b010;
  parameter ImmSelJ = 3'b011;
  parameter ImmSelU = 3'b100;
  parameter ImmSelR = 3'b111;
  //IF State
  wire [31:0] id_pc  ;
  //ID State
  wire [6:0]  id_opcode;
  wire [31:0] id_inst  ;
  wire [4:0]  id_rd    ;
  wire [4:0]  id_rs1   ;
  wire [4:0]  id_rs2   ;
  wire [2:0]  id_funct3;
  wire [6:0]  id_funct7;
  wire [2:0]  id_ImmSel;
  wire        id_PCSel ;
  wire        id_BrUn  ;
  wire        id_ASel  ;
  wire        id_BSel  ;
  wire        id_MemRW ;
  wire        id_RegWEn;
  wire [1:0]  id_WBSel ;
  wire [3:0]  id_ALUSel;
  wire [31:0] id_DataA ;
  wire [31:0] id_DataB ;
  wire [31:0] id_jump_pc;
  //EX State
  wire [31:0] ex_imm         ;
  wire        ex_we          ;
  wire [31:0] ex_DataA       ;
  wire [31:0] ex_DataB       ;
  wire [31:0] ex_pc          ;
  wire [4:0]  ex_rd          ;
  wire [4:0]  ex_rs1         ;
  wire [4:0]  ex_rs2         ;
  wire [2:0]  ex_ImmSel      ;
  wire        ex_BrEq        ;
  wire        ex_BrLT        ;
  wire        ex_PCSel       ;
  wire        ex_BrUn        ;
  wire        ex_ASel        ;
  wire        ex_BSel        ;
  wire        ex_MemRW       ;
  wire        ex_RegWEn      ;
  wire [1:0]  ex_WBSel       ;
  wire [3:0]  ex_ALUSel      ;
  wire [31:0] ex_inst        ;
  wire [31:0] ex_ALU_out     ;
  //wire [31:0] ex_ForwardDataB;
  //MEM State
  wire        mem_RegWEn ;
 // wire        mem_MemRW  ;
  wire [4:0]  mem_rd     ;
  wire [31:0] mem_imm    ;
 // wire [31:0] mem_ALU_out;
  wire [31:0] mem_DataB  ;
  wire [31:0] mem_pc     ;
  wire [31:0] mem_WBData ;
  wire [1:0]  mem_WBSel  ;
  wire [4:0]  mem_rs2    ;
  //WB State
  wire        wb_RegWEn  ;
  wire [4:0]  wb_rd      ;
  wire [31:0] wb_ALU_out ;
  wire [31:0] wb_DataB   ;
  wire [31:0] wb_pc      ;
  wire [31:0] wb_WBData  ;
  wire [31:0] wb_imm     ;
  //
  wire        PCWrite    ;
  wire        Reg_IF_ID_Data  ;
  wire [1:0]  ForwardASel;
  wire [1:0]  ForwardBSel;
//=========================IF STATE=========================//
//State IF
  State_IF_fpga State_IF_if
  (
  .clk        (clk         ),
  .rst_n      (rst_n       ),
  .ex_ALU_out (ex_ALU_out  ),
  .PCWrite    (PCWrite     ),
  .PCSel      (id_PCSel    ),
  .pc_next    (pc_next     ) 
  );
//=========================IF/ID REG=========================//
  Reg_IF_ID Reg_IF_ID_i
  (
  .clk    (clk    ),
  .rst_n  (rst_n  ),
  .if_pc  (if_pc  ),
  .if_inst(if_inst),
  .id_pc  (id_pc  ),
  .id_inst(id_inst) 
  );
//=========================ID STATE=========================//
  assign id_opcode = id_inst[6:0];
  assign id_rd     = ((id_ImmSel != ImmSelS) || (id_ImmSel != ImmSelB)) ? id_inst[11:7] : 0;
  assign id_rs1    = ((id_ImmSel != ImmSelJ) || (id_ImmSel != ImmSelU)) ? id_inst[19:15]: 0;
  assign id_rs2    = ((id_ImmSel == ImmSelR) || (id_ImmSel == ImmSelB) || (id_ImmSel== ImmSelS)) ? id_inst[24:20] : 0; 
  assign id_funct3 = ((id_ImmSel != ImmSelJ) || (id_ImmSel != ImmSelU)) ? id_inst[14:12] : 0;
  assign id_funct7 = (id_ImmSel == ImmSelR) ? id_inst[31:25] : 0;
//Control_Unit
  Control_Unit Control_Unit_i
  (
   .clk        (clk        ),
   .rst_n      (rst_n      ),
   .funct7     (id_funct7  ),
   .funct3     (id_funct3  ),
   .BrEq       (ex_BrEq    ),
   .BrLT       (ex_BrLT    ),
   .ImmSel     (id_ImmSel  ),
   .opcode     (id_opcode  ),
   .PCSel      (id_PCSel   ),
   .BrUn       (id_BrUn    ),
   .ASel       (id_ASel    ),
   .BSel       (id_BSel    ),
   .RegWEn     (id_RegWEn  ),
   .MemRW      (id_MemRW   ),
   .WBSel      (id_WBSel   ),
   .ALUSel     (id_ALUSel  ) 
  );
//Register_Array
  Register_Array Register_Array_i
  (
  .clk          (clk       ),
  .rst_n        (rst_n     ),
  .RegWEn       (wb_RegWEn ),
  .AddrD        (wb_rd     ),
  .DataD        (wb_WBData ),
  .AddrA        (id_rs1    ),
  .AddrB        (id_rs2    ),
  .DataA        (id_DataA  ),
  .DataB        (id_DataB  ) 
  );
//=========================ID/EX REG=========================//
  Reg_ID_EX Reg_ID_EX
  (
  .clk      (clk      ),
  .rst_n    (rst_n    ),
  .id_inst  (id_inst  ),
  .id_pc    (id_pc    ),
  .id_DataA (id_DataA ),
  .id_DataB (id_DataB ),
  .id_rd    (id_rd    ),
  .id_rs1   (id_rs1   ),
  .id_rs2   (id_rs2   ),
  .id_ImmSel(id_ImmSel),
  .id_PCSel (id_PCSel ),
  .id_BrUn  (id_BrUn  ),
  .id_ASel  (id_ASel  ),
  .id_BSel  (id_BSel  ),
  .id_MemRW (id_MemRW ),
  .id_RegWEn(id_RegWEn),
  .id_WBSel (id_WBSel ),
  .id_ALUSel(id_ALUSel),
  .ex_inst  (ex_inst  ),
  .ex_DataA (ex_DataA ),
  .ex_DataB (ex_DataB ),
  .ex_pc    (ex_pc    ),
  .ex_rd    (ex_rd    ),
  .ex_rs1   (ex_rs1   ),
  .ex_rs2   (ex_rs2   ),
  .ex_ImmSel(ex_ImmSel),
  .ex_PCSel (ex_PCSel ),
  .ex_BrUn  (ex_BrUn  ),
  .ex_ASel  (ex_ASel  ),
  .ex_BSel  (ex_BSel  ),
  .ex_MemRW (ex_MemRW ),
  .ex_RegWEn(ex_RegWEn),
  .ex_WBSel (ex_WBSel ),
  .ex_ALUSel(ex_ALUSel) 
  );
//=========================EXECUTE STATE=========================//
//Execute_Unit: ALU + Branch Compare + MUX Forward A/B
  Execute_Unit Execute_Unit_i
  (
  .clk            (clk            ),
  .rst_n          (rst_n          ),
  .id_BrUn        (ex_BrUn        ),
  .id_ASel        (ex_ASel        ),
  .id_BSel        (ex_BSel        ),
  .ex_pc          (ex_pc          ),
  .mem_ALU_out    (mem_ALU_out    ),
  .ForwardASel    (ForwardASel    ),
  .ForwardBSel    (ForwardBSel    ),
  .ex_DataA       (ex_DataA       ),
  .ex_DataB       (ex_DataB       ),
  .imm            (ex_imm         ),
  .wb_WBData      (wb_WBData      ),
//  .ex_WBSel       (ex_WBSel       ),
  .ex_ALUSel      (ex_ALUSel      ),
  .ex_ALU_out     (ex_ALU_out     ),
  .ex_ForwardDataB(ex_ForwardDataB),
  .ex_BrEq        (ex_BrEq        ),
  .ex_BrLT        (ex_BrLT        ) 
  );
//Imm_Gen
  Imm_Gen ImmGen_i
  (
//  .clk        (clk        ),
//  .rst_n      (rst_n      ),
  .inst       (ex_inst    ),
  .ImmSel     (ex_ImmSel  ),
  .imm        (ex_imm     ) 
  );
//=========================Reg EX/MEM=========================//

  Reg_EX_MEM Reg_EX_MEM
  (
  .clk        (clk        ),
  .rst_n      (rst_n      ),
  .ex_RegWEn  (ex_RegWEn  ),
  .ex_imm     (ex_imm     ),
  .ex_MemRW   (ex_MemRW   ),
  .ex_rd      (ex_rd      ),
  .ex_rs2     (ex_rs2     ),
  .ex_pc      (ex_pc      ),
  .ex_DataB   (ex_DataB   ),
  .ex_ALU_out (ex_ALU_out ),
  .ex_WBSel   (ex_WBSel   ),
  .mem_imm    (mem_imm    ),
  .mem_RegWEn (mem_RegWEn ),
  .mem_MemRW  (mem_MemRW  ),
  .mem_rd     (mem_rd     ),
  .mem_rs2    (mem_rs2    ),
  .mem_ALU_out(mem_ALU_out),
  .mem_DataB  (mem_DataB  ),
  .mem_pc     (mem_pc     ),
  .mem_WBSel  (mem_WBSel  ) 
  );
//=====================Reg_MEM_WB STATE=========================//

  Reg_MEM_WB Reg_MEM_WB_i
  (
  .clk        (clk        ),
  .rst_n      (rst_n      ),
  .mem_RegWEn (mem_RegWEn ),
  .mem_rd     (mem_rd     ),
  .mem_pc     (mem_pc     ),
  .mem_imm    (mem_imm    ),
  .mem_WBData (mem_WBData ),
  .mem_DataB  (DataB_out  ), //Come from Data Mem
  .mem_ALU_out(mem_ALU_out),
  .wb_imm     (wb_imm     ),
  .wb_RegWEn  (wb_RegWEn  ),
  .wb_rd      (wb_rd      ),
  .wb_ALU_out (wb_ALU_out ),
  .wb_DataB   (wb_DataB   ),
  .wb_WBData  (wb_WBData  ),
  .wb_pc      (wb_pc      ) 
  );
//
  wire [31:0] mem_pc_plus_1 = mem_pc + 32'h0001;
  mux2_4 WBMux_i
  (
  .sel(mem_WBSel    ),
  .in0(DataB_out    ),
  .in1(mem_ALU_out  ),
  .in2(mem_pc_plus_1),
  .in3(),
  .out(mem_WBData    ) 
  );
//=============INSTANCE HAZARD DETECTION============//

  Hazard_Detection_Unit Hazard_Detection_Unit_i
  (
  .id_rs1         (id_rs1        ),
  .id_rs2         (id_rs2        ),
  .ex_rd          (ex_rd         ),
  .ex_MemRW       (ex_MemRW      ),
  .PCWrite        (PCWrite       ),
  .Reg_IF_ID_Data (Reg_IF_ID_Data) 
  );
//=============INSTANCE FORWARDING UNIT============//

  Forwarding_Unit Forwarding_Unit_i
  (
  .ex_rs1     (ex_rs1     ),
  .ex_rs2     (ex_rs2     ),
  .mem_rd     (mem_rd     ),
  .wb_rd      (wb_rd      ),
  .mem_RegWEn (mem_RegWEn ),
  .wb_RegWEn  (wb_RegWEn  ),
  .mem_MemRW  (mem_MemRW  ),
  .ForwardASel(ForwardASel),
  .ForwardBSel(ForwardBSel) 
  );
endmodule
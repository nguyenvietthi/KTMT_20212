module risc_v_pipeline (
	input clk,    // Clock
	input rst_n,  // Asynchronous reset active low
);
  
  wire        hazard   ;
  wire        next_pc  ;
  wire [31:0] pc       ;
  wire [31:0] pc_add   ;
  wire [31:0] pc_jump  ;
  wire        pc_select;

  wire [31:0] inst;
  wire [31:0] imm_o;
  wire [31:0] pc_jump_result;
  reg  [31:0] delay_pc_jump_result;

  wire       br_eq          ;           
  wire       br_lt          ;           
  wire [6:0] opcode         ;         
  wire [6:0] funct7         ;         
  wire [2:0] funct3         ;         
  wire [2:0] imm_sel        ;
  wire       pc_sel         ;                 
  wire       br_un          ;           
  wire       ASel           ;           
  wire       BSel           ;           
  wire       MemRW          ;          
  wire       RegWEn         ;         
  wire [1:0] WBSel          ;          
  wire [3:0] ALUSel         ;         
  wire       insert_nop_flag;
 

  wire [31:0]  IF_ID_pc     ;  
  wire [31:0]  IF_ID_inst   ;
  wire [31:0]  IF_ID_rd     ;
  wire [31:0]  IF_ID_rd_next;
  wire [31:0]  IF_ID_rs1    ;
  wire [31:0]  IF_ID_rs2    ;
  wire         IF_ID_ASel   ;   
  wire         IF_ID_BSel   ;   
  wire         IF_ID_MemRW  ;  
  wire         IF_ID_RegWEn ; 
  wire [1:0]   IF_ID_WBSel  ;  
  wire [3:0]   IF_ID_ALUSel ; 

  wire [31:0] ID_EX_pc     ,
  wire [31:0] ID_EX_imm    ,
  wire [4:0]  ID_EX_rd     ,
  wire [4:0]  ID_EX_r1     ,
  wire [4:0]  ID_EX_r2     ,
  wire [31:0] ID_EX_data1  ,
  wire [31:0] ID_EX_data2  ,
  wire        ID_EX_ASel   ,
  wire        ID_EX_BSel   ,
  wire        ID_EX_MemRW  ,
  wire        ID_EX_RegWEn ,
  wire [1:0]  ID_EX_WBSel  ,
  wire [3:0]  ID_EX_ALUSel  

  // control
  control control_ins(
    .clk               (clk            ),
    .rst_n             (rst_n          ),
    .BrEq_i            (br_eq          ),
    .BrLT_i            (br_lt          ),
    .opcode_i          (opcode         ),
    .funct7_i          (funct7         ),
    .funct3_i          (funct3         ),
    .ImmSel_o          (imm_sel        ),
    .PCSel_o           (pc_sel         ),
    .BrUn_o            (br_un          ),
    .ASel_o            (ASel           ),
    .BSel_o            (BSel           ),
    .MemRW_o           (MemRW          ),
    .RegWEn_o          (RegWEn         ),
    .WBSel_o           (WBSel          ),
    .ALUSel_o          (ALUSel         ),
    .insert_nop_flag_o (insert_nop_flag)
  );

  // IF
  assign pc_select = pc_sel | insert_nop_flag;

  PC pc_ins(
    .clk        (clk    ),
    .rst_n      (rst_n  ),
    .hazardpc_i (hazard ),
    .pc_i       (next_pc),
    .pc_o       (pc     )
  );

  adder pc_adder_ins (
    .data1_i  (pc    ),
    .data2_i  ('d4   ),
    .result_o (pc_add)
  );

  mux21 pc_mux(
    .select_i (pc_select),
    .data1_i  (pc_add   ),
    .data2_i  (pc_jump  ),
    .data_o   (next_pc  )
  );

  instruction_memory instruction_memory_ins(
    .clk    (clk  ),
    .rst_n  (rst_n),
    .pc_i   (pc   ),
    .inst_o (inst )
  );

  // IF/ID
  IF_ID IF_ID_ins(
    .clk      (clk       ),
    .rst_n    (rst_n     ),
    .hazard_i (hazard    ),
    .flush_i  (pc_select ), // clear <=> insert nop
    .inst_i   (inst      ),
    .pc_i     (pc        ),
    .pc_o     (IF_ID_pc  ),
    .inst_o   (IF_ID_inst)
  );

  //ID
  instruction_decode instruction_decode_ins(
    .inst_i   (IF_ID_inst),
    .rd_o     (IF_ID_rd  ),
    .rs1_o    (IF_ID_rs1 ),
    .rs2_o    (IF_ID_rs2 ),
    .funct3_o (funct3    ),
    .funct7_o (funct7    ),
    .opcode_o (opcode    )
  );

  imm_gen imm_gen_ins(
    .inst_i   (IF_ID_inst),
    .imm_sel_i(imm_sel   ),
    .imm_o    (imm_o     )
  );

  adder pc_jump_adder(
    .data1_i  (IF_ID_pc      ),
    .data2_i  (imm_o         ),
    .result_o (pc_jump_result)
  );

  always_ff @(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
      delay_pc_jump_result <= 0;
    end else begin 
      delay_pc_jump_result <= pc_jump_result;
    end
  end

  mux21 pc_jump_mux(
    .select_i (insert_nop_flag     ),
    .data1_i  (pc_jump_result      ),
    .data2_i  (delay_pc_jump_result),
    .data_o   (pc_jump             )
  );

  register register_ins(
    .clk        (clk       ),
    .rst_n      (rst_n     ),
    .RSaddr_i   (IF_ID_rs1 ),
    .RTaddr_i   (IF_ID_rs2 ),
    .RDaddr_i   (  ),                                        adsasdsa
    .RDdata_i   (  ),
    .RegWrite_i (  ),                                      // dadaskldjhlaskfas;ofdjas;dkjsa;dks
    .RSdata_o   (data1     ),
    .RTdata_o   (data2     )
  );

  branch_comparator branch_comparator_ins(
    .BrUn_i (br_un),
    .DataA  (data1 ),
    .DataB  (data2),
    .BrEq_o (br_eq),
    .BrLt_o (br_lt)
  );

  control_mux control_mux_ins(
    .hazard_i (hazard       ), 
    .RegDst_i (IF_ID_rd     ), 
    .ASel_i   (ASel         ), 
    .BSel_i   (BSel         ), 
    .MemRW_i  (MemRW        ), 
    .RegWEn_i (RegWEn       ), 
    .WBSel_i  (WBSel        ), 
    .ALUSel_i (ALUSel       ), 
    .RegDst_o (IF_ID_rd_next), 
    .ASel_o   (IF_ID_ASel   ), 
    .BSel_o   (IF_ID_BSel   ), 
    .MemRW_o  (IF_ID_MemRW  ), 
    .RegWEn_o (IF_ID_RegWEn ), 
    .WBSel_o  (IF_ID_WBSel  ), 
    .ALUSel_o (IF_ID_ALUSel ) 
  );
 
  hazrad_detect hazrad_detect_ins(
    .IF_IDrs1_i      (IF_ID_rs1   ),
    .IF_IDrs2_i      (IF_ID_rs2   ),
    .ID_EXrd_i       (ID_EX_rd    ),
    .ID_EX_MemRead_i (~IF_ID_MemRW),
    .hazard_o        (hazard      )
  );


  ID_EX ID_EX_ins(
    .clk      (clk         ), 
    .rst_n    (rst_n       ), 
    .pc_i     (IF_ID_pc    ), 
    .imm_i    (imm_o       ), 
    .RegDst_i (IF_ID_rd    ), 
    .RegS1_i  (IF_ID_r1    ), 
    .RegS2_i  (IF_ID_r2    ), 
    .data1_i  (data1       ), 
    .data2_i  (data2       ), 
    .ASel_i   (IF_ID_ASel  ), 
    .BSel_i   (IF_ID_BSel  ), 
    .MemRW_i  (IF_ID_MemRW ), 
    .RegWEn_i (IF_ID_RegWEn), 
    .WBSel_i  (IF_ID_WBSel ), 
    .ALUSel_i (IF_ID_ALUSel), 
    .pc_o     (ID_EX_pc    ), 
    .imm_o    (ID_EX_imm   ), 
    .RegDst_o (ID_EX_rd    ), 
    .RegS1_o  (ID_EX_r1    ), 
    .RegS2_o  (ID_EX_r2    ), 
    .data1_o  (ID_EX_data1 ), 
    .data2_o  (ID_EX_data2 ), 
    .ASel_o   (ID_EX_ASel  ), 
    .BSel_o   (ID_EX_BSel  ), 
    .MemRW_o  (ID_EX_MemRW ), 
    .RegWEn_o (ID_EX_RegWEn), 
    .WBSel_o  (ID_EX_WBSel ), 
    .ALUSel_o (ID_EX_ALUSel), 
  );



endmodule : risc_v_pipeline
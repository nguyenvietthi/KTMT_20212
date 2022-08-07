module risc_v_pipeline (
	input clk,    // Clock
	input rst_n   // Asynchronous reset active low
);
  
  wire        hazard   ;
  wire [31:0] next_pc  ;
  wire [31:0] pc       ;
  wire [31:0] pc_add   ;
  wire [31:0] pc_jump  ;
  wire        pc_select;

  wire [31:0] inst;
  wire [31:0] imm_o;
  wire [31:0] pc_jump_result;
  reg  [31:0] delay_pc_jump_result;

  wire        br_eq          ;           
  wire        br_lt          ; 
  wire        br_ge          ;          
  wire [6:0]  opcode         ;         
  wire [6:0]  funct7         ;         
  wire [2:0]  funct3         ;         
  wire [2:0]  imm_sel        ;
  wire        pc_sel         ;                 
  wire        br_un          ;           
  wire        ASel           ;           
  wire        BSel           ;           
  wire        MemR           ;
  wire        MemW           ;          
  wire        RegWEn         ;         
  wire [1:0]  WBSel          ;          
  wire [3:0]  ALUSel         ;         
  wire        insert_nop_flag;
  wire [31:0] data1          ;
  wire [31:0] data2          ;
 
  wire [31:0]  IF_ID_pc     ;  
  wire [31:0]  IF_ID_inst   ;
  wire [4:0]   IF_ID_rd     ;
  wire [4:0]   IF_ID_rd_next;
  wire [4:0]   IF_ID_rs1    ;
  wire [4:0]   IF_ID_rs2    ;
  wire         IF_ID_ASel   ;   
  wire         IF_ID_BSel   ;   
  wire         IF_ID_MemR   ;  
  wire         IF_ID_MemW   ;  
  wire         IF_ID_RegWEn ; 
  wire [1:0]   IF_ID_WBSel  ;  
  wire [3:0]   IF_ID_ALUSel ; 

  wire [31:0] ID_EX_pc     ;
  wire [31:0] ID_EX_imm    ;
  wire [4:0]  ID_EX_rd     ;
  wire [4:0]  ID_EX_rs1    ;
  wire [4:0]  ID_EX_rs2    ;
  wire [31:0] ID_EX_data1  ;
  wire [31:0] ID_EX_data2  ;
  wire        ID_EX_ASel   ;
  wire        ID_EX_BSel   ;
  wire        ID_EX_MemR   ;
  wire        ID_EX_MemW   ;
  wire        ID_EX_RegWEn ;
  wire [1:0]  ID_EX_WBSel  ;
  wire [3:0]  ID_EX_ALUSel ;

  wire [31:0] alu_result           ;
  wire [31:0] data_wb              ;
  wire [31:0] EX_MEM_pc            ;   
  wire [31:0] EX_MEM_pc_add        ;
  wire [31:0] EX_MEM_ALU_result    ;    
  wire [31:0] EX_MEM_forward_b_data;  
  wire [4:0]  EX_MEM_rd            ; 
  wire        EX_MEM_MemR          ;  
  wire        EX_MEM_MemW          ;  
  wire        EX_MEM_RegWEn        ; 
  wire [1:0]  EX_MEM_WBSel         ; 


  wire [1:0]  forward_a          ;       
  wire [1:0]  forward_b          ;
  wire [1:0]  forward_comp1      ;
  wire [1:0]  forward_comp2      ;   
  wire [31:0] forward_a_data     ;        
  wire [31:0] forward_b_data     ;
  wire [31:0] forward_comp1_mux_o;
  wire [31:0] forward_comp2_mux_o;
  wire [31:0] alu_src_2          ;

  wire [31:0] mem_data_out     ;                 

  wire [4:0]  MEM_WB_rd        ;
  wire        MEM_WB_RegWEn    ;
  wire [31:0] MEM_WB_data_wb   ;

  // control
  control control_ins(
    .clk               (clk            ),
    .rst_n             (rst_n          ),
    .BrEq_i            (br_eq          ),
    .BrLT_i            (br_lt          ),
    .BrGe_i            (br_ge          ),
    .opcode_i          (opcode         ),
    .funct7_i          (funct7         ),
    .funct3_i          (funct3         ),
    .ImmSel_o          (imm_sel        ),
    .PCSel_o           (pc_sel         ),
    .BrUn_o            (br_un          ),
    .ASel_o            (ASel           ),
    .BSel_o            (BSel           ),
    .MemR_o            (MemR           ),
    .MemW_o            (MemW           ),
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
    .clk        (clk           ),
    .rst_n      (rst_n         ),
    .RSaddr_i   (IF_ID_rs1     ),
    .RTaddr_i   (IF_ID_rs2     ),
    .RDaddr_i   (MEM_WB_rd     ),
    .RDdata_i   (MEM_WB_data_wb),
    .RegWrite_i (MEM_WB_RegWEn ),
    .RSdata_o   (data1         ),
    .RTdata_o   (data2         )
  );

  mux31 forward_comp1_mux(
    .select_i (forward_comp1      ),
    .data1_i  (data1              ),
    .data2_i  (alu_result         ),
    .data3_i  (mem_data_out       ),
    .data_o   (forward_comp1_mux_o)
  );

  mux31 forward_comp2_mux(
    .select_i (forward_comp2      ),
    .data1_i  (data2              ),
    .data2_i  (alu_result         ),
    .data3_i  (mem_data_out       ),
    .data_o   (forward_comp2_mux_o)
  );

  branch_comparator branch_comparator_ins(
    .BrUn_i (br_un              ),
    .DataA  (forward_comp1_mux_o),
    .DataB  (forward_comp2_mux_o),
    .BrEq_o (br_eq              ),
    .BrLt_o (br_lt              ),
    .BrGe_o (br_ge              )
  );

  control_mux control_mux_ins(
    .hazard_i (hazard       ), 
    .RegDst_i (IF_ID_rd     ), 
    .ASel_i   (ASel         ), 
    .BSel_i   (BSel         ), 
    .MemR_i   (MemR         ),
    .MemW_i   (MemW         ),  
    .RegWEn_i (RegWEn       ), 
    .WBSel_i  (WBSel        ), 
    .ALUSel_i (ALUSel       ), 
    .RegDst_o (IF_ID_rd_next), 
    .ASel_o   (IF_ID_ASel   ), 
    .BSel_o   (IF_ID_BSel   ), 
    .MemR_o   (IF_ID_MemR   ),
    .MemW_o   (IF_ID_MemW   ),  
    .RegWEn_o (IF_ID_RegWEn ), 
    .WBSel_o  (IF_ID_WBSel  ), 
    .ALUSel_o (IF_ID_ALUSel ) 
  );
 
  hazrad_detect hazrad_detect_ins(
    .IF_IDrs1_i      (IF_ID_rs1   ),
    .IF_IDrs2_i      (IF_ID_rs2   ),
    .ID_EXrd_i       (ID_EX_rd    ),
    .ID_EX_MemRead_i (ID_EX_MemR  ),
    .hazard_o        (hazard      )
  );

  ID_EX ID_EX_ins(
    .clk      (clk         ), 
    .rst_n    (rst_n       ), 
    .pc_i     (IF_ID_pc    ), 
    .imm_i    (imm_o       ), 
    .RegDst_i (IF_ID_rd    ), 
    .RegS1_i  (IF_ID_rs1   ), 
    .RegS2_i  (IF_ID_rs2   ), 
    .data1_i  (data1       ), 
    .data2_i  (data2       ), 
    .ASel_i   (IF_ID_ASel  ), 
    .BSel_i   (IF_ID_BSel  ), 
    .MemR_i   (IF_ID_MemR  ),
    .MemW_i   (IF_ID_MemW  ),  
    .RegWEn_i (IF_ID_RegWEn), 
    .WBSel_i  (IF_ID_WBSel ), 
    .ALUSel_i (IF_ID_ALUSel), 
    .pc_o     (ID_EX_pc    ), 
    .imm_o    (ID_EX_imm   ), 
    .RegDst_o (ID_EX_rd    ), 
    .RegS1_o  (ID_EX_rs1   ), 
    .RegS2_o  (ID_EX_rs2   ), 
    .data1_o  (ID_EX_data1 ), 
    .data2_o  (ID_EX_data2 ), 
    .ASel_o   (ID_EX_ASel  ), 
    .BSel_o   (ID_EX_BSel  ), 
    .MemR_o   (ID_EX_MemR  ),
    .MemW_o   (ID_EX_MemW  ),  
    .RegWEn_o (ID_EX_RegWEn), 
    .WBSel_o  (ID_EX_WBSel ), 
    .ALUSel_o (ID_EX_ALUSel)
  );

  //EX
  forwarding_unit forwarding_unit_ins(
    .EX_MEM_RegWrite_i (EX_MEM_RegWEn),
    .ID_EX_RegWrite_i  (ID_EX_RegWEn ),
    .MEM_WB_RegWrite_i (MEM_WB_RegWEn),
    .EX_MEM_MemR_i     (EX_MEM_MemR  ),
    .EX_MEM_RD_i       (EX_MEM_rd    ),
    .IF_ID_RS_i        (IF_ID_rs1    ),
    .IF_ID_RT_i        (IF_ID_rs2    ),
    .ID_EX_RS_i        (ID_EX_rs1    ),
    .ID_EX_RT_i        (ID_EX_rs2    ),
    .ID_EX_RD_i        (ID_EX_rd     ),
    .MEM_WB_RD_i       (MEM_WB_rd    ),
    .ForwardA_o        (forward_a    ),
    .ForwardB_o        (forward_b    ),
    .forward_comp1_o   (forward_comp1),
    .forward_comp2_o   (forward_comp2)
  );

  mux31 forward_a_mux_ins(
    .select_i (forward_a        ),
    .data1_i  (ID_EX_data1      ),
    .data2_i  (MEM_WB_data_wb   ),
    .data3_i  (EX_MEM_ALU_result),
    .data_o   (forward_a_data   )
  ); 

  mux31 forward_b_mux_ins(
    .select_i (forward_b        ),
    .data1_i  (ID_EX_data2      ),
    .data2_i  (MEM_WB_data_wb   ),
    .data3_i  (EX_MEM_ALU_result),
    .data_o   (forward_b_data   )
  ); 

  mux21 bsel_mux_ins(
    .select_i (ID_EX_BSel     ),
    .data1_i  (forward_b_data ),
    .data2_i  (ID_EX_imm      ),
    .data_o   (alu_src_2      )
  );

  ALU ALU_ins(
    .src1      (forward_a_data),
    .src2      (alu_src_2     ),
    .ALU_sel   (ID_EX_ALUSel  ),
    .alu_result(alu_result    ),
    .zero_flag (              )
  );

  //EX/MEM

  EX_MEM EX_MEM_ins(
    .clk               (clk                  ),
    .rst_n             (rst_n                ),
    .pc_i              (ID_EX_pc             ),
    .ALU_i             (alu_result           ),
    .forward_b_data_i  (forward_b_data       ),
    .RegDst_i          (ID_EX_rd             ),
    .MemR_i            (ID_EX_MemR           ),
    .MemW_i            (ID_EX_MemW           ),
    .RegWEn_i          (ID_EX_RegWEn         ),
    .WBSel_i           (ID_EX_WBSel          ),

    .pc_o              (EX_MEM_pc            ),
    .ALU_o             (EX_MEM_ALU_result    ),
    .forward_b_data_o  (EX_MEM_forward_b_data),
    .RegDst_o          (EX_MEM_rd            ),
    .MemR_o            (EX_MEM_MemR          ),
    .MemW_o            (EX_MEM_MemW          ),
    .RegWEn_o          (EX_MEM_RegWEn        ),
    .WBSel_o           (EX_MEM_WBSel         )
  );

  // EX
  data_memory data_memory_ins(
    .clk         (clk                  ),
    .rst_n       (rst_n                ),
    .op_addr     (                     ),
    .addr_i      (EX_MEM_ALU_result    ),
    .data_i      (EX_MEM_forward_b_data),
    .mem_write_i (EX_MEM_MemW          ),
    .mem_read_i  (EX_MEM_MemR          ),

    .data_o      (mem_data_out         ),
    .data_mem_o  (                     )
  );

  adder EX_MEM_pc_adder_ins (
    .data1_i  (EX_MEM_pc    ),
    .data2_i  ('d4          ),
    .result_o (EX_MEM_pc_add)
  );

  mux31 data_wb_mux_ins(
    .select_i (EX_MEM_WBSel     ),
    .data1_i  (mem_data_out     ),
    .data2_i  (EX_MEM_ALU_result),
    .data3_i  (EX_MEM_pc_add    ),
    .data_o   (data_wb          )
  ); 

  // EX_MEM
  MEM_WB MEM_WB_ins(
    .clk       (clk           ),
    .rst_n     (rst_n         ),
    .RegDst_i  (EX_MEM_rd     ),
    .RegWEn_i  (EX_MEM_RegWEn ),
    .data_wb_i (data_wb       ),

    .RegDst_o  (MEM_WB_rd     ),
    .RegWEn_o  (MEM_WB_RegWEn ),
    .data_wb_o (MEM_WB_data_wb)
  );

endmodule : risc_v_pipeline
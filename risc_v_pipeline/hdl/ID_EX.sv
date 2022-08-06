module ID_EX(
    input             clk      ,
    input             rst_n    ,

    input      [31:0] pc_i     ,
    input      [31:0] imm_i    ,
    input      [4:0]  RegDst_i ,
    input      [4:0]  RegS1_i  ,
    input      [4:0]  RegS2_i  ,
    input      [31:0] data1_i  ,
    input      [31:0] data2_i  ,
    input             ASel_i   ,
    input             BSel_i   ,
    input             MemR_i   ,
    input             MemW_i   ,
    input             RegWEn_i ,
    input      [1:0]  WBSel_i  ,
    input      [3:0]  ALUSel_i ,  

    output reg [31:0] pc_o     ,
    output reg [31:0] imm_o    ,
    output reg [4:0]  RegDst_o ,
    output reg [4:0]  RegS1_o  ,
    output reg [4:0]  RegS2_o  ,
    output reg [31:0] data1_o  ,
    output reg [31:0] data2_o  ,
    output reg        ASel_o   ,
    output reg        BSel_o   ,
    output reg        MemR_o   ,
    output reg        MemW_o   ,
    output reg        RegWEn_o ,
    output reg [1:0]  WBSel_o  ,
    output reg [3:0]  ALUSel_o  
);

    always@(posedge clk or negedge rst_n) begin
      if(~rst_n) begin
            pc_o     <= 'b0;
            imm_o    <= 'b0;
            RegDst_o <= 'b0;
            RegS1_o  <= 'b0;
            RegS2_o  <= 'b0;
            data1_o  <= 'b0;
            data2_o  <= 'b0;
            ASel_o   <= 'b0;
            BSel_o   <= 'b0;
            MemR_o   <= 'b0;
            MemW_o   <= 'b0;
            RegWEn_o <= 'b0;
            WBSel_o  <= 'b0;
            ALUSel_o <= 'b0;
      end
      else begin
            pc_o     <= pc_i    ;
            imm_o    <= imm_i   ;
            RegDst_o <= RegDst_i;
            RegS1_o  <= RegS1_i ;
            RegS2_o  <= RegS2_i ;
            data1_o  <= data1_i ;
            data2_o  <= data2_i ;
            ASel_o   <= ASel_i  ;
            BSel_o   <= BSel_i  ;
            MemR_o   <= MemR_i  ;
            MemW_o   <= MemW_i  ;
            RegWEn_o <= RegWEn_i;
            WBSel_o  <= WBSel_i ;
            ALUSel_o <= ALUSel_i;
      end
    end

endmodule




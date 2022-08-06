module EX_MEM(
    input             clk             ,
    input             rst_n           ,

    input      [31:0] pc_i            ,
    input      [31:0] ALU_i           ,
    input      [31:0] forward_b_data_i,
    input      [4:0]  RegDst_i        ,
    input             MemR_i          ,
    input             MemW_i          ,
    input             RegWEn_i        ,
    input      [1:0]  WBSel_i         ,

    output reg [31:0] pc_o            ,
    output reg [31:0] ALU_o           ,
    output reg [31:0] forward_b_data_o,
    output reg [4:0]  RegDst_o        ,
    output reg        MemR_o          ,
    output reg        MemW_o          ,
    output reg        RegWEn_o        ,
    output reg [1:0]  WBSel_o         
);

  always@(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
      pc_o              <= 'b0;
      ALU_o             <= 'b0;
      forward_b_data_o  <= 'b0;
      RegDst_o          <= 'b0;
      MemR_o            <= 'b0;
      MemW_o            <= 'b0;
      RegWEn_o          <= 'b0;
      WBSel_o           <= 'b0;
    end
    else begin
      pc_o              <= pc_i            ;
      ALU_o             <= ALU_i           ;
      forward_b_data_o  <= forward_b_data_i;
      RegDst_o          <= RegDst_i        ;
      MemR_o            <= MemR_i          ;
      MemW_o            <= MemW_i          ;
      RegWEn_o          <= RegWEn_i        ;
      WBSel_o           <= WBSel_i         ;
    end
  end

endmodule
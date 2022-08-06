module MEM_WB(
    input             clk      ,
    input             rst_n    ,

    input      [4:0]  RegDst_i ,
    input             RegWEn_i ,
    input      [31:0] data_wb_i,

    output reg [4:0]  RegDst_o ,
    output reg        RegWEn_o ,
    output reg [31:0] data_wb_o
);

    always@(posedge clk or negedge rst_n) begin
      if(~rst_n) begin
        RegDst_o  <= 'b0;
        RegWEn_o  <= 'b0;
        data_wb_o <= 'b0;
      end
      else begin
        RegDst_o  <= RegDst_i ;
        RegWEn_o  <= RegWEn_i ;
        data_wb_o <= data_wb_i;
      end
    end

endmodule
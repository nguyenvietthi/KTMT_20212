module IF_ID(
    input               clk     ,
    input               rst_n   ,
    input               hazard_i, 
    input               flush_i ,
    input       [31:0]  inst_i  , 
    input       [31:0]  pc_i    ,
    output reg  [31:0]  pc_o    , 
    output reg  [31:0]  inst_o  
);

    always@(posedge clk or posedge rst_n) begin
      if(~rst_n) begin
        pc_o <= 32'b0;
        inst_o <= 32'b0;
      end else 
      if(hazard_i) begin 
        pc_o <= pc_o;
        inst_o <= inst_o;
      end else 
      if(flush_i) begin
        pc_o <= pc_i;
        inst_o <= 32'b0;
      end else begin
        pc_o <= pc_i;
        inst_o <= inst_i;
      end
    end
    
endmodule


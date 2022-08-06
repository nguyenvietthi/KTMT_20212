module PC(
    input               clk       ,
    input               rst_n     ,
    input               hazardpc_i,
    input       [31:0]  pc_i      ,
    output reg  [31:0]  pc_o      
);
  
    always@(posedge clk or negedge rst_n) begin
        if(~rst_n) begin
            pc_o <= 32'b0;
        end
        else begin
            if(rst_n & (!hazardpc_i))
                pc_o <= pc_i ;
            else
                pc_o <= pc_o;
        end
    end

endmodule

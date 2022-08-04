module control_mux(
    input            Hazard_i ,
    input      [4:0] RegDst_i ,
    input            ASel_i   ,
    input            BSel_i   ,
    input            MemRW_i  ,
    input            RegWEn_i ,
    input      [1:0] WBSel_i  ,
    input      [3:0] ALUSel_i ,  

    output reg [4:0] RegDst_o ,
    output reg       ASel_o   ,
    output reg       BSel_o   ,
    output reg       MemRW_o  ,
    output reg       RegWEn_o ,
    output reg [1:0] WBSel_o  ,
    output reg [3:0] ALUSel_o  
);

    always @(*) begin
        if(Hazard_i) begin 
            RegDst_o = 'b0;
            ASel_o   = 'b0;
            BSel_o   = 'b0;
            MemRW_o  = 'b0;
            RegWEn_o = 'b0;
            WBSel_o  = 'b0;
            ALUSel_o = 'b0;
        end else begin 
            RegDst_o = RegDst_i;
            ASel_o   = ASel_i  ;
            BSel_o   = BSel_i  ;
            MemRW_o  = MemRW_i ;
            RegWEn_o = RegWEn_i;
            WBSel_o  = WBSel_i ;
            ALUSel_o = ALUSel_i;
        end  
    end
endmodule
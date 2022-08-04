module forwarding_unit(   
    input  [4:0] EX_MEM_RegWrite_i,
    input  [4:0] EX_MEM_RD_i      ,
    input  [4:0] ID_EX_RS_i       ,
    input  [4:0] ID_EX_RT_i       ,
    input        MEM_WB_RegWrite_i,
    input        MEM_WB_RD_i      ,
    output [1:0] ForwardA_o       ,
    output [1:0] ForwardB_o        
);

always@(*)begin

    if(EX_MEM_RegWrite_i && (EX_MEM_RD_i != 5'b00000) && (EX_MEM_RD_i == ID_EX_RS_i)) begin 
        ForwardA_o = 2'b10;
    end else 
    if(MEM_WB_RegWrite_i && (MEM_WB_RD_i != 5'b00000) && MEM_WB_RD_i == ID_EX_RS_i) begin 
        ForwardA_o = 2'b01;
    end else begin 
        ForwardA_o = 2'b00;
    end

    if(EX_MEM_RegWrite_i && (EX_MEM_RD_i != 5'b00000) && (EX_MEM_RD_i == ID_EX_RT_i)) begin 
        ForwardB_o = 2'b10;
    end else 
    if(MEM_WB_RegWrite_i && (MEM_WB_RD_i != 5'b00000) && MEM_WB_RD_i == ID_EX_RT_i) begin 
        ForwardB_o = 2'b01;
    end else begin 
        ForwardB_o = 2'b00;
    end 
end 
endmodule
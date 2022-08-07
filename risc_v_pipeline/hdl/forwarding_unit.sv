module forwarding_unit(   
    input            EX_MEM_RegWrite_i,
    input            ID_EX_RegWrite_i ,
    input            MEM_WB_RegWrite_i,
    input            EX_MEM_MemR_i    ,
    input      [4:0] EX_MEM_RD_i      ,
    input      [4:0] IF_ID_RS_i       ,
    input      [4:0] IF_ID_RT_i       ,
    input      [4:0] ID_EX_RS_i       ,
    input      [4:0] ID_EX_RT_i       ,
    input      [4:0] ID_EX_RD_i       ,
    input      [4:0] MEM_WB_RD_i      ,
    output reg [1:0] ForwardA_o       ,
    output reg [1:0] ForwardB_o       ,
    output reg [1:0] forward_comp1_o  ,
    output reg [1:0] forward_comp2_o    
);

always@(*)begin
    // A
    if(EX_MEM_RegWrite_i && (EX_MEM_RD_i != 5'b00000) && (EX_MEM_RD_i == ID_EX_RS_i)) begin 
        ForwardA_o = 2'b10;//EX hazard
    end else 
    if(MEM_WB_RegWrite_i && (MEM_WB_RD_i != 5'b00000) && MEM_WB_RD_i == ID_EX_RS_i) begin 
        ForwardA_o = 2'b01;//MEM hazard
    end else begin 
        ForwardA_o = 2'b00;
    end
    // B
    if(EX_MEM_RegWrite_i && (EX_MEM_RD_i != 5'b00000) && (EX_MEM_RD_i == ID_EX_RT_i)) begin 
        ForwardB_o = 2'b10;//EX hazard
    end else 
    if(MEM_WB_RegWrite_i && (MEM_WB_RD_i != 5'b00000) && MEM_WB_RD_i == ID_EX_RT_i) begin 
        ForwardB_o = 2'b01;//MEM hazard
    end else begin 
        ForwardB_o = 2'b00;
    end 

    //comp_A
    if ((ID_EX_RD_i != 0) && ID_EX_RegWrite_i && (IF_ID_RS_i == ID_EX_RD_i)) begin
      forward_comp1_o = 2'b01;
    end else 
    if (EX_MEM_MemR_i && (EX_MEM_RD_i != 0) && EX_MEM_RegWrite_i && (EX_MEM_RD_i == IF_ID_RS_i)) begin
      forward_comp1_o = 2'b10;
    end
    else forward_comp1_o = 2'b00;

    //comp_B
    if ((ID_EX_RD_i != 0) && ID_EX_RegWrite_i && (IF_ID_RT_i == ID_EX_RD_i)) begin
      forward_comp2_o = 2'b01;
    end else 
    if (EX_MEM_MemR_i && (EX_MEM_RD_i != 0) && EX_MEM_RegWrite_i && (EX_MEM_RD_i == IF_ID_RT_i)) begin
      forward_comp2_o = 2'b10;
    end
    else forward_comp2_o = 2'b00;

end 
endmodule
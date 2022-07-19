module Hazard_Detection_Unit(
      input              clk            ,
      input              rst_n          ,
      input  wire[4:0]   id_rs1         ,
      input  wire[4:0]   id_rs2         ,
      input  wire[4:0]   ex_rd          ,
      input      [6:0]   opcode         ,
      input              ex_MemRW       ,
      output reg         PCWrite        ,
      output             Reg_IF_ID_Data  
);
//Instrucion type
parameter NoP     = 7'b0000000;
parameter R       = 7'b0110011;
parameter addi    = 7'b0010011;
parameter lw      = 7'b0000011;
parameter sw      = 7'b0100011;
parameter SB      = 7'b1100011;
parameter jalr    = 7'b1100111;
parameter jal     = 7'b1101111;
parameter auipc   = 7'b0010111;

  reg [1:0] cnt0    ;
  reg [1:0] cnt1    ;
  wire      cnt_en0 ;
  reg       cnt_en1 ;
  wire      PCWrite0;
  wire      PCWrite1;
//  assign PCWrite = PCWrite0 || PCWrite1;
  assign cnt_en0 = ((opcode == SB) || (opcode == jalr)) ? 1 : 0;
  assign PCWrite0= ((cnt0 == 1) || (cnt0 == 2)) ? 0 : 1;
  assign PCWrite1= (cnt1 == 1) ? 0 : 1;
  assign Reg_IF_ID_Data = ((cnt0 == 1) || (cnt0 == 2)) ? 0 : 1;
  always @(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
      cnt0 <= 0;
    end else begin
      if (cnt_en0) begin
        if (cnt0 < 2) begin
          cnt0 <= cnt0 +1;
        end else cnt0 <= 0;
      end 
      else cnt0 <= 0;
    end
  end
  always @(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
      cnt1 <= 0;
    end else begin
      if (cnt_en1) begin
        if (cnt1 < 1) begin
          cnt1 <= cnt1 +1;
        end else cnt1 <= 0;
      end 
      else cnt1 <= 0;
    end
  end
  always @(*) begin
    if((ex_MemRW == 0) && (ex_rd == id_rs1) && (ex_rd != 0)) begin
      cnt_en1          = 1;
    end
    else begin
      cnt_en1          = 0;
    end
//
    if((ex_MemRW == 0) && (ex_rd == id_rs2) && (ex_rd != 0)) begin
      cnt_en1          = 1;
    end
    else begin
      cnt_en1          = 0;
    end
  end
  always @(*) begin : proc_PCWrite
    if ((opcode == SB) || (opcode == jalr)) begin
      PCWrite = PCWrite0;
    end 
    else PCWrite = PCWrite1;
  end
endmodule
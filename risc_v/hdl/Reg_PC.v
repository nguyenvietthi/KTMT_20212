module Reg_PC(
  input         clk             ,
  input         rst_n           ,
  input  [31:0] ALU_out         ,
  input  [31:0] jump_pc         ,
  input         PCWrite         ,// From Hazard Detection, 1: No harzard; 0: Hazard detected
  input  [1:0]  PCSel           ,// From Control Unit
  output [31:0] pc_next          // To Instruction Mem
  );
  reg [31:0] pc_curr;
  wire[31:0] pc_plus_1;
  assign pc_plus_1 = pc_curr + 32'h0001;
  assign pc_next = PCWrite ? pc_curr : 0;// Nop: addi x0,x0,0
  always @(posedge clk or negedge rst_n) begin : proc_pc
    if(~rst_n) begin
      pc_curr <= 0;
    end else begin
      if (PCWrite == 0) begin
        pc_curr <=  pc_curr;
      end
      else begin
        if (PCSel == 1) begin
          pc_curr <= ALU_out;
        end
        else begin
          if (PCSel == 0) begin
            pc_curr <= pc_plus_1;
          end
          else pc_curr <= jump_pc;
        end
      end
    end
  end
endmodule
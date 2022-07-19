module State_IF_fpga (
  input        clk         ,  // Clock
  input        rst_n       ,  // Asynchronous reset active low
  input [31:0] ex_ALU_out  ,
  input        PCWrite     ,
  input        PCSel       ,
  output[31:0] pc_next      
);
//=========================INSTANCE=========================//
  Reg_PC Reg_PC_i
  (
  .clk         (clk        ),
  .rst_n       (rst_n      ),
  .ALU_out     (ex_ALU_out ),
  .PCWrite     (PCWrite    ),
  .PCSel       (PCSel      ),
  .pc_next     (pc_next    ) 
  );
endmodule
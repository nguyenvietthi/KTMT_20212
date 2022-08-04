module instruction_memory(
  input        clk   ,
  input        rst_n ,
  input [31:0] pc_i  ,
  output[31:0] inst_o 
);
  reg [31:0] inst_memory [200:0];
  initial begin
      $readmemb("/data1/workspace/phucph0/new/Computer-Architecture-20202/RISC_V/simple_run.txt", inst_memory);
  end
  assign inst_o =  inst_memory[pc_i << 2]; 
endmodule
module instruction_memory(
  input        clk   ,
  input        rst_n ,
  input [31:0] pc_i  ,
  output[31:0] inst_o 
);
  reg [31:0] inst_memory [50:0];
  initial begin
      $readmemh("D:/OneDrive - Hanoi University of Science and Technology/NAM 4/20212/KTMT/KTMT_20212/risc_v_pipeline/sim/tb/inst_mem_data.txt", inst_memory);
      
      $display("\nInstruction Memory: ");
      for(int i = 0; i < 50; i++) begin 
        $display("[%d]: 'h%h", i, inst_memory[i]);
      end
  end

  assign inst_o =  inst_memory[pc_i >> 2]; 

endmodule
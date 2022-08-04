module data_memory (
  input               clk        ,
  input               rst_n      ,
  input   [4:0]       op_addr    ,
  input   [31:0]      addr_i     ,
  input   [31:0]      data_i     ,
  input               mem_write_i, 
  input               mem_read_i ,
  output  [31:0]      data_o     ,
  output  [31:0]      data_mem_o 
);

  reg [7:0] memory [0:31];
  wire [31:0] op;
  
  assign op = { memory[addr_i + 3],memory[addr_i + 2], memory[addr_i + 1], memory[addr_i]};
  
  assign data_mem_o = { memory[op_addr + 3],memory[op_addr + 2], memory[op_addr + 1],memory[op_addr]};
  
  assign data_o = (mem_read_i) ? op : 32'b0;
  
  always @(posedge clk or posedge rst_n) begin
      if(rst_n) begin 
        for(int i=0; i < 32; i = i + 1) memory[i] <= 0;
      end else 
      if(mem_write_i) begin
        memory[addr_i + 3] <= data_i[31:24];
        memory[addr_i + 2] <= data_i[23:16];
        memory[addr_i + 1] <= data_i[15:8];
        memory[addr_i    ] <= data_i[7:0];
      end
  end
endmodule
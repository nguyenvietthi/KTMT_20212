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

  reg [7:0] memory [0:119];
  wire [31:0] op;
  
  assign op = { memory[addr_i + 3],memory[addr_i + 2], memory[addr_i + 1], memory[addr_i]};
  
  assign data_mem_o = { memory[op_addr + 3],memory[op_addr + 2], memory[op_addr + 1],memory[op_addr]};
  
  assign data_o = (mem_read_i) ? op : 32'b0;
  
  always @(posedge clk or posedge rst_n) begin
      if(~rst_n) begin 
        for(int i=0; i < 120; i = i + 1) memory[i] <= 0;
      end else 
      if(mem_write_i) begin
        memory[addr_i + 3] <= data_i[31:24];
        memory[addr_i + 2] <= data_i[23:16];
        memory[addr_i + 1] <= data_i[15:8];
        memory[addr_i    ] <= data_i[7:0];
      end
  end
  
`ifdef DATA_MEMORY_LOG
always_comb begin
    $display("\n@ %1d ns => DATA MEMORY", $realtime());
  for(int i = 0; i < 30; i++) begin
    if(memory[i] !== 'hx)begin 
        $display("  [%3d] = 'h%2h, [%3d] = 'h%2h, [%3d] = 'h%2h, [%3d] = 'h%2h => data = %1d",
         i*4 + 3, memory[i*4 + 3], i*4 + 2, memory[i*4 + 2], i*4 + 1, memory[i*4 + 1], i*4, memory[i*4],
          $signed({memory[i*4 + 3], memory[i*4 + 2], memory[i*4 + 1], memory[i*4]}));
    end else begin 
        break;   
    end 
  end
end
`endif

endmodule
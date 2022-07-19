module Data_Memory(
 input           clk            ,
 input           rst_n          ,
 input  [31:0]   AddrB          ,
 input  [31:0]   DataWrite      ,
 input           MemRW          ,
 output [31:0]   DataB           
);

  reg [31:0] memory_array [31:0];
  integer f;
  wire [31:0] addr = AddrB[31:0];
//Load memory_array from file

  initial begin
    $readmemb("/data1/workspace/phucph0/new/Computer-Architecture-20202/RISC_V/mem.txt", memory_array);
//    f = $fopen(`filename);
//    $fmonitor(f, "time = %d\n", $time, 
//    "\tmemory_array[0] = %b\n", memory_array[0],
//    "\tmemory_array[1] = %b\n", memory_array[1],
//    "\tmemory_array[2] = %b\n", memory_array[2],
//    "\tmemory_array[3] = %b\n", memory_array[3],
//    "\tmemory_array[4] = %b\n", memory_array[4],
//    "\tmemory_array[5] = %b\n", memory_array[5],
//    "\tmemory_array[6] = %b\n", memory_array[6],
//    "\tmemory_array[7] = %b\n", memory_array[7]);
//    `simulation_time;
//    $fclose(f);
  end
  always @(posedge clk or negedge rst_n) begin : proc_memory_array
    if(~rst_n) begin
       //memory_array <= 0;
    end 
    else begin
       if (MemRW == 1)
         memory_array[addr] <= DataWrite;
    end
  end
 assign DataB = (MemRW == 0) ? memory_array[addr]: 0; 

endmodule
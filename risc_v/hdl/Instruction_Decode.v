module Instruction_Decode (
  input                   clk             ,// Clock
  input                   rst_n           ,// Asynchronous reset active low
  input  [32:0]           instruction     , // Instruction from Instruction Memory
  output [4:0]            rd              ,
  output [4:0]            rs1             ,
  output [4:0]            rs2             ,
  output [2:0]            funct3          ,
  output [6:0]            funct7           

);
  assign opcode = instruction[6:0]  ; //Opcode to Control Unit
  assign rd     = instruction[11:7] ; //Register Destination
  assign rs1    = instruction[19:15]; //Register Source 1
  assign rs2    = instruction[24:20]; //Register Source 2
  assign funct3 = instruction[14:12];
  assign funct7 = instruction[31:25];
endmodule
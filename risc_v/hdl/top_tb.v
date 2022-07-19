`timescale 1ns / 1ps
module top_tb();
 // Inputs
 reg clk;
 reg rst_n;
//
 Risc_32_bit DUT (
  .clk  (clk  ),
  .rst_n(rst_n)
 );

 initial 
  begin
    rst_n <= 0;
    clk <=0;
    #10 rst_n <= 1;
    #200;
   $finish;
  end

 always 
  begin
   #5 clk = ~clk;
  end

endmodule
 `timescale 1ns/1ps
module risc_v_pipeline_tb ();

  reg clk  ;
  reg rst_n;

  always #10 clk = ~clk;

  risc_v_pipeline risc_v_pipeline_ins(
    .clk   (clk  ),
    .rst_n (rst_n)
  );

  initial begin 
    clk             = 0;
    rst_n           = 0;
    @(negedge clk);
    rst_n = 1;

    repeat(1000) @(negedge clk);
    $stop;
  end
endmodule
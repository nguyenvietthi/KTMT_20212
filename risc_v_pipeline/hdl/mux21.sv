module mux21(
  input          select_i,
  input  [31:0]  data1_i ,
  input  [31:0]  data2_i ,
  output [31:0]  data_o  
);

  assign data_o = (select_i) ? data2_i : data1_i ;

endmodule
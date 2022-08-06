module hazrad_detect(
  input [4:0]  IF_IDrs1_i     ,
  input [4:0]  IF_IDrs2_i     ,
  input [4:0]  ID_EXrd_i      ,
  input        ID_EX_MemRead_i,
  output       hazard_o       
);
 
  assign hazard_o = ((ID_EX_MemRead_i && (ID_EXrd_i == IF_IDrs1_i || ID_EXrd_i == IF_IDrs2_i) && (ID_EXrd_i != 'b0)) ? 1'b1 : 1'b0);

endmodule

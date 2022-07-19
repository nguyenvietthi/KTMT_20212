module Branch_Comparator
(
  input        BrUn    ,
  input  [31:0]ex_DataA,
  input  [31:0]ex_DataB,
  output  reg  BrEq    ,
  output  reg  BrLt     
);
always @(*) begin
  if (BrUn) begin
      BrEq = (ex_DataA == ex_DataB) ? 1'b1 : 1'b0;
      BrLt = (ex_DataA < ex_DataB) ? 1'b1 : 1'b0;
  end
  else begin
      BrEq = ($signed(ex_DataA) == $signed(ex_DataB)) ? 1'b1 : 1'b0;
      BrLt = ($signed(ex_DataA) <  $signed(ex_DataB)) ? 1'b1 : 1'b0;
  end
end

endmodule
module branch_comparator(
  input               BrUn_i,
  input       [31:0]  DataA ,
  input       [31:0]  DataB ,
  output reg          BrEq_o,
  output reg          BrLt_o      
);
always @(*) begin
  if (BrUn_i) begin
      BrEq_o = (ex_DataA == ex_DataB) ? 1'b1 : 1'b0;
      BrLt_o = (ex_DataA < ex_DataB) ? 1'b1 : 1'b0;
  end
  else begin
      BrEq_o = ($signed(ex_DataA) == $signed(ex_DataB)) ? 1'b1 : 1'b0;
      BrLt_o = ($signed(ex_DataA) <  $signed(ex_DataB)) ? 1'b1 : 1'b0;
  end
end

endmodule
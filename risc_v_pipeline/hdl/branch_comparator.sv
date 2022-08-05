module branch_comparator(
  input               BrUn_i,
  input       [31:0]  DataA ,
  input       [31:0]  DataB ,
  output reg          BrEq_o,
  output reg          BrLt_o      
);
    assign BrEq_o = (ex_DataA == ex_DataB) ? 1'b1 : 1'b0;
    
    always @(*) begin
      if (BrUn_i) begin
          BrLt_o = (ex_DataA <  ex_DataB) ? 1'b1 : 1'b0;
      end
      else begin
          BrLt_o = ($signed(ex_DataA) <  $signed(ex_DataB)) ? 1'b1 : 1'b0;
      end
    end

endmodule
module adder (
	input  [31:0] data1_i  ,
	input  [31:0] data2_i  ,
	output [31:0] result_o
);
	assign result_o = data1_i + data2_i;
endmodule
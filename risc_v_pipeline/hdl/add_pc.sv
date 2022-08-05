module add_pc (
	input  		  clk	  , 
	input  		  rst_n	  ,
	input  [31:0] pc_i 	  ,
	output [31:0] pc_add_o	
);
	assign pc_add_o = pc_i + 4;
endmodule
module mux31(
    input      [1:0]   select_i,
    input      [31:0]  data1_i ,
    input      [31:0]  data2_i ,
    input      [31:0]  data3_i ,
    output reg [31:0]  data_o    
);

    always @(*) begin
      case(select_i)
            2'b00: data_o = data1_i;
    
            2'b01: data_o = data2_i;
    
            2'b10: data_o = data3_i; 
    
            default : data_o = data1_i;
      endcase
    end

endmodule
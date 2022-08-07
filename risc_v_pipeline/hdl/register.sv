module register(
    input                  clk       ,
    input                  rst_n     ,
    input      [4:0]       RSaddr_i  ,
    input      [4:0]       RTaddr_i  ,
    input      [4:0]       RDaddr_i  ,
    input      [31:0]      RDdata_i  ,
    input                  RegWrite_i,
    output reg [31:0]      RSdata_o  ,
    output reg [31:0]      RTdata_o   
);

// Register File
reg [31:0] register [0:31];

always @(*) begin
    if(RSaddr_i == 'b0) begin 
        RSdata_o = 0;
    end else begin
        RSdata_o = register[RSaddr_i];
    end
end

always @(*) begin
    if(RTaddr_i == 'b0) begin 
        RTdata_o = 0;
    end else begin
        RTdata_o = register[RTaddr_i];
    end
end

// Write Data
always@(negedge clk or posedge rst_n)begin
    if(~rst_n) begin
        for(int i = 0; i < 32; i = i + 1) register[i] <= 0;
    end else 
    begin
        if(RegWrite_i && RDaddr_i != 'b0) begin
            register[RDaddr_i] <= RDdata_i;
        end
    end      
end

`ifdef REGISTER_LOG
always_comb begin
    $display("\n@ %1d ns => REGISTER", $realtime());
  for(int i = 0; i < 32; i++) begin
    if(register[i] !== 'bx)begin 
        $display("  [%2d]: %1d", i, $signed(register[i]));
    end else begin 
        break;   
    end 
  end
end
`endif

endmodule 

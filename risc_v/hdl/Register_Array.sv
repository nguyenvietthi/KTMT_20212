module Register_Array (
    input  wire               clk    ,
    input  wire               rst_n  ,
    input  wire               RegWEn ,
    input  wire [4:0]         AddrD  ,
    input  wire [31:0]        DataD  ,
    input  wire [4:0]         AddrA  ,
    output reg  [31:0]        DataA  ,
    input  wire [4:0]         AddrB  ,
    output reg  [31:0]        DataB   
);
    reg[31:0]  regs[0:31];
/*
    initial begin
        regs [1] = 32'd5;
        regs [2] = 0;
        regs [3] = 1;
        regs [4] = 32'd10;
        regs [5] = 1;
        regs [6] = 0;
        regs [7] = 1;
        regs [8] = 0;
        regs [9] = 1;
        regs [10] = 0;
        regs [11] = 1;
        regs [12] = 0;
        regs [13] = 1;
        regs [14] = 0;
    end
*/
    // write
    always @ (posedge clk) begin
        if (!rst_n) begin
            regs[0]  <=0;
            regs [1] <=0;
            regs [2] <=0;
            regs [3] <=0;
            regs [4] <=0;
            regs [5] <=0;
            regs [6] <=0;
            regs [7] <=0;
            regs [8] <=0;
            regs [9] <=0;
            regs [10]<=0;
            regs [11]<=0;
            regs [12]<=0;
            regs [13]<=0;
            regs [14]<=0;
            regs [15]<=0;
            regs [16]<=0;
            regs [18]<=0;
            regs [19]<=0;
            regs [20]<=0;
            regs [21]<=0;
            regs [22]<=0;
            regs [23]<=0;
            regs [24]<=0;
            regs [25]<=0;
            regs [26]<=0;
            regs [28]<=0;
            regs [29]<=0;
            regs [30]<=0;
            regs [31]<=0;
        end
        else begin
            // x0 cannot be written
            if (RegWEn && AddrD != 0) begin
                //$display("WRITE REGISTER FILE: x%d = %h", AddrD, DataD);
                regs[AddrD] <= DataD;
            end
        end
    end
    // read 1
    always @ (*) begin
        if (!rst_n || AddrA == 0) begin
            DataA <= 0;
        end else if (!RegWEn && AddrA == AddrD) begin
            DataA <= DataD;
        end else begin
            DataA <= regs[AddrA];
        end
    end

    // read 2
    always @ (*) begin
        if (!rst_n || AddrB == 0) begin
            DataB <= 0;
        end else if (!RegWEn && AddrB == AddrD) begin
            DataB <= DataD;
        end else begin
            DataB <= regs[AddrB];
        end
    end

endmodule
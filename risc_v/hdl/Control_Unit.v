module Control_Unit(
    input            clk    ,
    input            rst_n  ,
    input            BrEq   ,
    input            BrLT   ,
    input      [6:0] opcode ,
    input      [6:0] funct7 ,
    input      [2:0] funct3 ,
    output reg [2:0] ImmSel ,
    output reg [1:0] PCSel  ,
    output reg       BrUn   ,
    output reg       ASel   ,
    output reg       BSel   ,
    output reg       MemRW  ,
    output reg       RegWEn ,
    output reg [1:0] WBSel  ,
    output reg [3:0] ALUSel  
);

// Parameter file
//Immediate selection
parameter ImmSelI = 3'b000;
parameter ImmSelS = 3'b001;
parameter ImmSelB = 3'b010;
parameter ImmSelJ = 3'b011;
parameter ImmSelU = 3'b100;
parameter ImmSelR = 3'b111;

//ALU operation
parameter ALUadd  =  4'b0000;
parameter ALUsub  =  4'b0001;
parameter ALUsll  =  4'b0010;
parameter ALUslt  =  4'b0011;
parameter ALUsltu =  4'b0100;
parameter ALUxor  =  4'b0101;
parameter ALUsrl  =  4'b0110;
parameter ALUsra  =  4'b0111;
parameter ALUor   =  4'b1000;
parameter ALUand  =  4'b1001;
parameter ALUnop  =  4'b1111;

//Instrucion type
parameter NoP     = 7'b0000000;
parameter R       = 7'b0110011;
parameter addi    = 7'b0010011;
parameter lw      = 7'b0000011;
parameter sw      = 7'b0100011;
parameter SB      = 7'b1100011;
parameter jalr    = 7'b1100111;
parameter jal     = 7'b1101111;
parameter auipc   = 7'b0010111;
always @(*)
begin
    case(opcode)
    R:
        case(funct3)
        3'b000:
            case(funct7)
            7'b0000000: //add
                begin
                    PCSel       = 0; //PC=PC+4
                    ImmSel      = ImmSelR;
                    //BrUn        = 1'b0;
                    ASel        = 0; //Reg
                    BSel        = 0; //Reg
                    ALUSel      = ALUadd;
                    MemRW       = 0; //Read
                    RegWEn      = 1;
                    WBSel       = 2'b01; //ALU
                end
            7'b0100000: //sub
                begin
                    PCSel       = 0; //PC=PC+4
                    ImmSel      = ImmSelR;
                    //BrUn        = 1'b0;
                    ASel        = 0; //Reg
                    BSel        = 0; //Reg
                    ALUSel      = ALUsub;
                    MemRW       = 0; //Read
                    RegWEn      = 1;
                    WBSel       = 2'b01; //ALU
                end
            endcase
        3'b001: //sll
            begin
                PCSel           = 0; //PC=PC+4
                ImmSel          = ImmSelR;
                // BrUn            = 1'bx;
                ASel            = 0; //Reg
                BSel            = 0; //Reg
                ALUSel          = ALUsll;
                MemRW           = 0;//Read
                RegWEn          = 1;
                WBSel           = 2'b01; //ALU
            end
        3'b010: //slt
            begin
                PCSel           = 0; //PC=PC+4
                ImmSel          = ImmSelR;
                // BrUn            = 1'bx;
                ASel            = 0; //Reg
                BSel            = 0; //Reg
                ALUSel          = ALUslt;
                MemRW           = 0; //Read
                RegWEn          = 1;
                WBSel           = 2'b01; //ALU
            end
        3'b011: //sltu
            begin
                PCSel           = 0; //PC=PC+4
                ImmSel          = ImmSelR;
                // BrUn            = 1'bx;
                ASel            = 0; //Reg
                BSel            = 0; //Reg
                ALUSel          = ALUsltu;
                MemRW           = 0; //Read
                RegWEn          = 1;
                WBSel           = 2'b01; //ALU
            end
        3'b100: //xor
            begin
                PCSel           = 0; //PC=PC+4
                ImmSel          = ImmSelR;
                // BrUn            = 1'bx;
                ASel            = 0; //Reg
                BSel            = 0; //Reg
                ALUSel          = ALUxor;
                MemRW           = 0; //Read
                RegWEn          = 1;
                WBSel           = 2'b01; //ALU
            end
        3'b101:
            case(funct7)
            7'b0000000: //srl
                begin
                    PCSel       = 0; //PC=PC+4
                    ImmSel      = ImmSelR;
                    // BrUn        = 1'bx;
                    ASel        = 0; //Reg
                    BSel        = 0; //Reg
                    ALUSel      = ALUsrl;
                    MemRW       = 0; //Read
                    RegWEn      = 1;
                    WBSel       = 2'b01; //ALU
                end
            7'b0100000: //sra
                begin
                    PCSel       = 0; //PC=PC+4
                    ImmSel      = ImmSelR;
                    // BrUn        = 1'bx;
                    ASel        = 0; //Reg
                    BSel        = 0; //Reg
                    ALUSel      = ALUsra;
                    MemRW       = 0; //Read
                    RegWEn      = 1;
                    WBSel       = 2'b01; //ALU
                end
            endcase
        3'b110: //or
            begin
                PCSel           = 0; //PC=PC+4
                ImmSel          = ImmSelR;
                // BrUn            = 1'bx;
                ASel            = 0; //Reg
                BSel            = 0; //Reg
                ALUSel          = ALUor;
                MemRW           = 0; //Read
                RegWEn          = 1;
                WBSel           = 2'b01; //ALU
            end
        3'b111: //and
            begin
                PCSel           = 0; //PC=PC+4
                ImmSel          = ImmSelR;
                // BrUn            = 1'bx;
                ASel            = 0; //Reg
                BSel            = 0; //Reg
                ALUSel          = ALUand;
                MemRW           = 0; //Read
                RegWEn          = 1;
                WBSel           = 2'b01; //ALU
            end
        endcase
    addi:
        begin
            PCSel               = 0; //PC=PC+4
            ImmSel              = ImmSelI; //Immediate type I
            // BrUn                = 1'bx;
            ASel                = 0; //Reg
            BSel                = 1; //Imm
            ALUSel              = ALUadd;
            MemRW               = 0; //Read
            RegWEn              = 1;
            WBSel               = 2'b01; //ALU
        end
    lw:
        begin
            PCSel               = 0; //PC=PC+4
            ImmSel              = ImmSelI; //Immediate type I
            BrUn                = 1'bx;
            ASel                = 0; //Reg
            BSel                = 1; //Imm
            ALUSel              = ALUadd;
            MemRW               = 0; //Read
            RegWEn              = 1;
            WBSel               = 2'b00; //Mem
            end
    sw:
        begin
            PCSel               = 0; //PC=PC+4
            ImmSel              = ImmSelS; //Immediate type S
            BrUn                = 1'bx;
            ASel                = 0; //Reg
            BSel                = 1; //Imm
            ALUSel              = ALUadd;
            MemRW               = 1; //Write
            RegWEn              = 0;
            WBSel               = 2'bxx;
            end
    SB:
        case(funct3)
        3'b000: //beq // Branchcomp block read BrEq and change PCSel
            begin
                PCSel           = (BrEq) ? 1 : 0; //PC=PC+Imm when Eq, PC= PC+4 when not Eq
                ImmSel          = ImmSelB; //Immediate type B
                // BrUn            = 1'bx;
                ASel            = 1; //PC
                BSel            = 1; //Imm
                ALUSel          = ALUadd;
                MemRW           = 0; //Read
                RegWEn          = 0;
                WBSel           = 2'bxx;
            end
        3'b001: //bne //Branchcomp read BrEq and change PCSel
            begin
                PCSel           = (BrLT) ? 0 : 1; //ALU // temporary value
                ImmSel          = ImmSelB; //Immediate type B
                // BrUn            = 1'bx;
                ASel            = 1; //PC
                BSel            = 1; //Imm
                ALUSel          = ALUadd;
                MemRW           = 0; //Read
                RegWEn          = 0;
                WBSel           = 2'bxx;
            end
        3'b100: //blt //Branchcomp read BrLT and change PCSel
            begin
                PCSel           = (BrLT) ? 1 : 0; //PC+4 // temporary value
                ImmSel          = ImmSelB; //Immediate type B
                BrUn            = 0;
                ASel            = 1; //PC
                BSel            = 1; //Imm
                ALUSel          = ALUadd;
                MemRW           = 0;//Read
                RegWEn          = 0;
                WBSel           = 2'bxx;
            end
        3'b101: //bltu //Branchcomp read BrLT and change PCSel
            begin
                PCSel           = (BrLT) ? 1 : 0; //PC+4 // temporary value
                ImmSel          = ImmSelB; //Immediate type B
                BrUn            = 1;
                ASel            = 1; //PC
                BSel            = 1; //Imm
                ALUSel          = ALUadd;
                MemRW           = 0; //Read
                RegWEn          = 0;
                WBSel           = 2'bxx;
            end
        endcase
    jalr:
        begin
            PCSel               = 2; //jump_pc
            ImmSel              = ImmSelI; //Immediate type I
            // BrUn                = 1'bx;
            ASel                = 0; //Reg
            BSel                = 1; //Imm
            ALUSel              = ALUadd;
            MemRW               = 0; //Read
            RegWEn              = 1;
            WBSel               = 2'b10; // PC+4
        end
    jal:
        begin
            PCSel               = 2; //jump_pc
            ImmSel              = ImmSelJ; //Immediate type J
            ASel                = 1; //PC
            BSel                = 1; //Imm
            ALUSel              = ALUadd;
            MemRW               = 0; //Read
            RegWEn              = 1;
            WBSel               = 2'b10; // PC+4
        end
    auipc:
        begin
            PCSel               = 0; //PC+4
            ImmSel              = ImmSelU; //Immediate type U
            BrUn                = 1'bx;
            ASel                = 1; //PC
            BSel                = 1; //Imm
            ALUSel              = ALUadd;
            MemRW               = 0; //Read
            RegWEn              = 1;
            WBSel               = 2'b01; // ALU
        end
    default: ALUSel             = ALUnop;
    endcase
end
endmodule

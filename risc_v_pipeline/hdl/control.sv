module control (
    input            clk      ,
    input            rst_n    ,
    input            BrEq_i   ,
    input            BrLT_i   ,
    input      [6:0] opcode_i ,
    input      [6:0] funct7_i ,
    input      [2:0] funct3_i ,
    output reg [2:0] ImmSel_o ,
    output reg       PCSel_o  ,
    output reg       BrUn_o   ,
    output reg       ASel_o   ,
    output reg       BSel_o   ,
    output reg       MemRW_o  ,
    output reg       RegWEn_o ,
    output reg [1:0] WBSel_o  ,
    output reg [3:0] ALUSel_o  
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
  parameter B       = 7'b1100011;
  parameter jalr    = 7'b1100111;
  parameter jal     = 7'b1101111;
  parameter auipc   = 7'b0010111;
  
  always @(*)
  begin
      case(opcode_i)
      R:
          case(funct3_i)
          3'b000:
              case(funct7_i)
              7'b0000000: //add
                  begin
                      PCSel_o       = 0; //PC=PC+4
                      ImmSel_o      = ImmSelR;
                      //BrUn_o        = 1'b0;
                      ASel_o        = 0; //Reg
                      BSel_o        = 0; //Reg
                      ALUSel_o      = ALUadd;
                      MemRW_o       = 0; //Read
                      RegWEn_o      = 1;
                      WBSel_o       = 2'b01; //ALU
                  end
              7'b0100000: //sub
                  begin
                      PCSel_o       = 0; //PC=PC+4
                      ImmSel_o      = ImmSelR;
                      //BrUn_o        = 1'b0;
                      ASel_o        = 0; //Reg
                      BSel_o        = 0; //Reg
                      ALUSel_o      = ALUsub;
                      MemRW_o       = 0; //Read
                      RegWEn_o      = 1;
                      WBSel_o       = 2'b01; //ALU
                  end
              endcase
          3'b001: //sll
              begin
                  PCSel_o           = 0; //PC=PC+4
                  ImmSel_o          = ImmSelR;
                  // BrUn_o            = 1'bx;
                  ASel_o            = 0; //Reg
                  BSel_o            = 0; //Reg
                  ALUSel_o          = ALUsll;
                  MemRW_o           = 0;//Read
                  RegWEn_o          = 1;
                  WBSel_o           = 2'b01; //ALU
              end
          3'b010: //slt
              begin
                  PCSel_o           = 0; //PC=PC+4
                  ImmSel_o          = ImmSelR;
                  // BrUn_o            = 1'bx;
                  ASel_o            = 0; //Reg
                  BSel_o            = 0; //Reg
                  ALUSel_o          = ALUslt;
                  MemRW_o           = 0; //Read
                  RegWEn_o          = 1;
                  WBSel_o           = 2'b01; //ALU
              end
          3'b011: //sltu
              begin
                  PCSel_o           = 0; //PC=PC+4
                  ImmSel_o          = ImmSelR;
                  // BrUn_o            = 1'bx;
                  ASel_o            = 0; //Reg
                  BSel_o            = 0; //Reg
                  ALUSel_o          = ALUsltu;
                  MemRW_o           = 0; //Read
                  RegWEn_o          = 1;
                  WBSel_o           = 2'b01; //ALU
              end
          3'b100: //xor
              begin
                  PCSel_o           = 0; //PC=PC+4
                  ImmSel_o          = ImmSelR;
                  // BrUn_o            = 1'bx;
                  ASel_o            = 0; //Reg
                  BSel_o            = 0; //Reg
                  ALUSel_o          = ALUxor;
                  MemRW_o           = 0; //Read
                  RegWEn_o          = 1;
                  WBSel_o           = 2'b01; //ALU
              end
          3'b101:
              case(funct7_i)
              7'b0000000: //srl
                  begin
                      PCSel_o       = 0; //PC=PC+4
                      ImmSel_o      = ImmSelR;
                      // BrUn_o        = 1'bx;
                      ASel_o        = 0; //Reg
                      BSel_o        = 0; //Reg
                      ALUSel_o      = ALUsrl;
                      MemRW_o       = 0; //Read
                      RegWEn_o      = 1;
                      WBSel_o       = 2'b01; //ALU
                  end
              7'b0100000: //sra
                  begin
                      PCSel_o       = 0; //PC=PC+4
                      ImmSel_o      = ImmSelR;
                      // BrUn_o        = 1'bx;
                      ASel_o        = 0; //Reg
                      BSel_o        = 0; //Reg
                      ALUSel_o      = ALUsra;
                      MemRW_o       = 0; //Read
                      RegWEn_o      = 1;
                      WBSel_o       = 2'b01; //ALU
                  end
              endcase
          3'b110: //or
              begin
                  PCSel_o           = 0; //PC=PC+4
                  ImmSel_o          = ImmSelR;
                  // BrUn_o            = 1'bx;
                  ASel_o            = 0; //Reg
                  BSel_o            = 0; //Reg
                  ALUSel_o          = ALUor;
                  MemRW_o           = 0; //Read
                  RegWEn_o          = 1;
                  WBSel_o           = 2'b01; //ALU
              end
          3'b111: //and
              begin
                  PCSel_o           = 0; //PC=PC+4
                  ImmSel_o          = ImmSelR;
                  // BrUn_o            = 1'bx;
                  ASel_o            = 0; //Reg
                  BSel_o            = 0; //Reg
                  ALUSel_o          = ALUand;
                  MemRW_o           = 0; //Read
                  RegWEn_o          = 1;
                  WBSel_o           = 2'b01; //ALU
              end
          endcase
      addi:
          case(funct3_i)
          3'b000:
              case(funct7_i)
              7'b0000000: //add
                  begin
                      PCSel_o       = 0; //PC=PC+4
                      ImmSel_o      = ImmSelR;
                      //BrUn_o        = 1'b0;
                      ASel_o        = 0; //Reg
                      BSel_o        = 0; //Reg
                      ALUSel_o      = ALUadd;
                      MemRW_o       = 0; //Read
                      RegWEn_o      = 1;
                      WBSel_o       = 2'b01; //ALU
                  end
              7'b0100000: //sub
                  begin
                      PCSel_o       = 0; //PC=PC+4
                      ImmSel_o      = ImmSelR;
                      //BrUn_o        = 1'b0;
                      ASel_o        = 0; //Reg
                      BSel_o        = 0; //Reg
                      ALUSel_o      = ALUsub;
                      MemRW_o       = 0; //Read
                      RegWEn_o      = 1;
                      WBSel_o       = 2'b01; //ALU
                  end
              endcase
          3'b001: //sll
              begin
                  PCSel_o           = 0; //PC=PC+4
                  ImmSel_o          = ImmSelR;
                  // BrUn_o            = 1'bx;
                  ASel_o            = 0; //Reg
                  BSel_o            = 0; //Reg
                  ALUSel_o          = ALUsll;
                  MemRW_o           = 0;//Read
                  RegWEn_o          = 1;
                  WBSel_o           = 2'b01; //ALU
              end
          3'b010: //slt
              begin
                  PCSel_o           = 0; //PC=PC+4
                  ImmSel_o          = ImmSelR;
                  // BrUn_o            = 1'bx;
                  ASel_o            = 0; //Reg
                  BSel_o            = 0; //Reg
                  ALUSel_o          = ALUslt;
                  MemRW_o           = 0; //Read
                  RegWEn_o          = 1;
                  WBSel_o           = 2'b01; //ALU
              end
          3'b011: //sltu
              begin
                  PCSel_o           = 0; //PC=PC+4
                  ImmSel_o          = ImmSelR;
                  // BrUn_o            = 1'bx;
                  ASel_o            = 0; //Reg
                  BSel_o            = 0; //Reg
                  ALUSel_o          = ALUsltu;
                  MemRW_o           = 0; //Read
                  RegWEn_o          = 1;
                  WBSel_o           = 2'b01; //ALU
              end
          3'b100: //xor
              begin
                  PCSel_o           = 0; //PC=PC+4
                  ImmSel_o          = ImmSelR;
                  // BrUn_o            = 1'bx;
                  ASel_o            = 0; //Reg
                  BSel_o            = 0; //Reg
                  ALUSel_o          = ALUxor;
                  MemRW_o           = 0; //Read
                  RegWEn_o          = 1;
                  WBSel_o           = 2'b01; //ALU
              end
          3'b101:
              case(funct7_i)
              7'b0000000: //srl
                  begin
                      PCSel_o       = 0; //PC=PC+4
                      ImmSel_o      = ImmSelR;
                      // BrUn_o        = 1'bx;
                      ASel_o        = 0; //Reg
                      BSel_o        = 0; //Reg
                      ALUSel_o      = ALUsrl;
                      MemRW_o       = 0; //Read
                      RegWEn_o      = 1;
                      WBSel_o       = 2'b01; //ALU
                  end
              7'b0100000: //sra
                  begin
                      PCSel_o       = 0; //PC=PC+4
                      ImmSel_o      = ImmSelR;
                      // BrUn_o        = 1'bx;
                      ASel_o        = 0; //Reg
                      BSel_o        = 0; //Reg
                      ALUSel_o      = ALUsra;
                      MemRW_o       = 0; //Read
                      RegWEn_o      = 1;
                      WBSel_o       = 2'b01; //ALU
                  end
              endcase
          3'b110: //or
              begin
                  PCSel_o           = 0; //PC=PC+4
                  ImmSel_o          = ImmSelR;
                  // BrUn_o            = 1'bx;
                  ASel_o            = 0; //Reg
                  BSel_o            = 0; //Reg
                  ALUSel_o          = ALUor;
                  MemRW_o           = 0; //Read
                  RegWEn_o          = 1;
                  WBSel_o           = 2'b01; //ALU
              end
          3'b111: //and
              begin
                  PCSel_o           = 0; //PC=PC+4
                  ImmSel_o          = ImmSelR;
                  // BrUn_o            = 1'bx;
                  ASel_o            = 0; //Reg
                  BSel_o            = 0; //Reg
                  ALUSel_o          = ALUand;
                  MemRW_o           = 0; //Read
                  RegWEn_o          = 1;
                  WBSel_o           = 2'b01; //ALU
              end
          endcase
      lw:
          begin
              PCSel_o               = 0; //PC=PC+4
              ImmSel_o              = ImmSelI; //Immediate type I
              BrUn_o                = 1'bx;
              ASel_o                = 0; //Reg
              BSel_o                = 1; //Imm
              ALUSel_o              = ALUadd;
              MemRW_o               = 0; //Read
              RegWEn_o              = 1;
              WBSel_o               = 2'b00; //Mem
              end
      sw:
          begin
              PCSel_o               = 0; //PC=PC+4
              ImmSel_o              = ImmSelS; //Immediate type S
              BrUn_o                = 1'bx;
              ASel_o                = 0; //Reg
              BSel_o                = 1; //Imm
              ALUSel_o              = ALUadd;
              MemRW_o               = 1; //Write
              RegWEn_o              = 0;
              WBSel_o               = 2'bxx;
              end
      B:
          case(funct3_i)
          3'b000: //beq // Branchcomp block read BrEq_i and change PCSel_o
              begin
                  PCSel_o           = (BrEq_i) ? 1 : 0; //PC=PC+Imm when Eq, PC= PC+4 when not Eq
                  ImmSel_o          = ImmSelB; //Immediate type B
                  // BrUn_o            = 1'bx;
                  ASel_o            = 1; //PC
                  BSel_o            = 1; //Imm
                  ALUSel_o          = ALUadd;
                  MemRW_o           = 0; //Read
                  RegWEn_o          = 0;
                  WBSel_o           = 2'bxx;
              end
          3'b001: //bne //Branchcomp read BrEq_i and change PCSel_o
              begin
                  PCSel_o           = (BrLT_i) ? 0 : 1; //ALU // temporary value
                  ImmSel_o          = ImmSelB; //Immediate type B
                  // BrUn_o            = 1'bx;
                  ASel_o            = 1; //PC
                  BSel_o            = 1; //Imm
                  ALUSel_o          = ALUadd;
                  MemRW_o           = 0; //Read
                  RegWEn_o          = 0;
                  WBSel_o           = 2'bxx;
              end
          3'b100: //blt //Branchcomp read BrLT_i and change PCSel_o
              begin
                  PCSel_o           = (BrLT_i) ? 1 : 0; //PC+4 // temporary value
                  ImmSel_o          = ImmSelB; //Immediate type B
                  BrUn_o            = 0;
                  ASel_o            = 1; //PC
                  BSel_o            = 1; //Imm
                  ALUSel_o          = ALUadd;
                  MemRW_o           = 0;//Read
                  RegWEn_o          = 0;
                  WBSel_o           = 2'bxx;
              end
          3'b101: //bltu //Branchcomp read BrLT_i and change PCSel_o
              begin
                  PCSel_o           = (BrLT_i) ? 1 : 0; //PC+4 // temporary value
                  ImmSel_o          = ImmSelB; //Immediate type B
                  BrUn_o            = 1;
                  ASel_o            = 1; //PC
                  BSel_o            = 1; //Imm
                  ALUSel_o          = ALUadd;
                  MemRW_o           = 0; //Read
                  RegWEn_o          = 0;
                  WBSel_o           = 2'bxx;
              end
          endcase
      jalr:
          begin
              PCSel_o               = 2; //jump_pc
              ImmSel_o              = ImmSelI; //Immediate type I
              // BrUn_o                = 1'bx;
              ASel_o                = 0; //Reg
              BSel_o                = 1; //Imm
              ALUSel_o              = ALUadd;
              MemRW_o               = 0; //Read
              RegWEn_o              = 1;
              WBSel_o               = 2'b10; // PC+4
          end
      jal:
          begin
              PCSel_o               = 1; //jump_pc
              ImmSel_o              = ImmSelJ; //Immediate type J
              ASel_o                = 1; //PC
              BSel_o                = 1; //Imm
              ALUSel_o              = ALUadd;
              MemRW_o               = 0; //Read
              RegWEn_o              = 1;
              WBSel_o               = 2'b10; // PC+4
          end
      auipc:
          begin
              PCSel_o               = 0; //PC+4
              ImmSel_o              = ImmSelU; //Immediate type U
              BrUn_o                = 1'bx;
              ASel_o                = 1; //PC
              BSel_o                = 1; //Imm
              ALUSel_o              = ALUadd;
              MemRW_o               = 0; //Read
              RegWEn_o              = 1;
              WBSel_o               = 2'b01; // ALU
          end
      default: ALUSel_o             = ALUnop;
      endcase
  end
endmodule

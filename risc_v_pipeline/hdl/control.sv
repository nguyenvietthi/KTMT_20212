`include "risc_v_pipeline_define.svh"
module control (
    input            clk              ,
    input            rst_n            ,
    input            BrEq_i           ,
    input            BrLT_i           ,
    input            BrGe_i           ,
    input      [6:0] opcode_i         ,
    input      [6:0] funct7_i         ,
    input      [2:0] funct3_i         ,
    output reg [2:0] ImmSel_o         ,
    output reg       PCSel_o          ,
    output reg       BrUn_o           ,
    output reg       ASel_o           ,
    output reg       BSel_o           ,
    output reg       MemR_o           ,
    output reg       MemW_o           ,
    output reg       RegWEn_o         ,
    output reg [1:0] WBSel_o          ,
    output reg [3:0] ALUSel_o         ,
    output           insert_nop_flag_o
);
  //insert 2 nop for JAL
  reg  count          ;
  wire detect_jal     ;

  assign detect_jal = (opcode_i == `J);

  always @(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
      count <= 0;
    end else if(detect_jal) begin
      count <= count + 1;
    end else begin
      count <= 0;
    end
  end

  assign insert_nop_flag_o = detect_jal || (count == 1'b1);

  // Control logic
  always @(*)
  begin
      case(opcode_i)
      `R:
          case(funct3_i)
          3'b000:
              case(funct7_i)
              7'b0000000: //add
                  begin
                      PCSel_o       = 0; //PC=PC+4
                      ImmSel_o      = `ImmSelR;
                      //BrUn_o        = 1'b0;
                      ASel_o        = 0; //Reg
                      BSel_o        = 0; //Reg
                      ALUSel_o      = `ALUadd;
                      MemR_o        = 0;
                      MemW_o        = 0;
                      RegWEn_o      = 1;
                      WBSel_o       = 2'b01; //ALU
                  end
              7'b0100000: //sub
                  begin
                      PCSel_o       = 0; //PC=PC+4
                      ImmSel_o      = `ImmSelR;
                      //BrUn_o        = 1'b0;
                      ASel_o        = 0; //Reg
                      BSel_o        = 0; //Reg
                      ALUSel_o      = `ALUsub;
                      MemR_o        = 0;
                      MemW_o        = 0;
                      RegWEn_o      = 1;
                      WBSel_o       = 2'b01; //ALU
                  end
              endcase
          3'b001: //sll
              begin
                  PCSel_o           = 0; //PC=PC+4
                  ImmSel_o          = `ImmSelR;
                  // BrUn_o            = 1'bx;
                  ASel_o            = 0; //Reg
                  BSel_o            = 0; //Reg
                  ALUSel_o          = `ALUsll;
                  MemR_o            = 0;
                  MemW_o            = 0;
                  RegWEn_o          = 1;
                  WBSel_o           = 2'b01; //ALU
              end
          3'b010: //slt
              begin
                  PCSel_o           = 0; //PC=PC+4
                  ImmSel_o          = `ImmSelR;
                  // BrUn_o            = 1'bx;
                  ASel_o            = 0; //Reg
                  BSel_o            = 0; //Reg
                  ALUSel_o          = `ALUslt;
                  MemR_o            = 0;
                  MemW_o            = 0;
                  RegWEn_o          = 1;
                  WBSel_o           = 2'b01; //ALU
              end
          3'b011: //sltu
              begin
                  PCSel_o           = 0; //PC=PC+4
                  ImmSel_o          = `ImmSelR;
                  // BrUn_o            = 1'bx;
                  ASel_o            = 0; //Reg
                  BSel_o            = 0; //Reg
                  ALUSel_o          = `ALUsltu;
                  MemR_o            = 0;
                  MemW_o            = 0;
                  RegWEn_o          = 1;
                  WBSel_o           = 2'b01; //ALU
              end
          3'b100: //xor
              begin
                  PCSel_o           = 0; //PC=PC+4
                  ImmSel_o          = `ImmSelR;
                  // BrUn_o            = 1'bx;
                  ASel_o            = 0; //Reg
                  BSel_o            = 0; //Reg
                  ALUSel_o          = `ALUxor;
                  MemR_o            = 0;
                  MemW_o            = 0;
                  RegWEn_o          = 1;
                  WBSel_o           = 2'b01; //ALU
              end
          3'b101:
              case(funct7_i)
              7'b0000000: //srl
                  begin
                      PCSel_o       = 0; //PC=PC+4
                      ImmSel_o      = `ImmSelR;
                      // BrUn_o        = 1'bx;
                      ASel_o        = 0; //Reg
                      BSel_o        = 0; //Reg
                      ALUSel_o      = `ALUsrl;
                      MemR_o        = 0;
                      MemW_o        = 0;
                      RegWEn_o      = 1;
                      WBSel_o       = 2'b01; //ALU
                  end
              7'b0100000: //sra
                  begin
                      PCSel_o       = 0; //PC=PC+4
                      ImmSel_o      = `ImmSelR;
                      // BrUn_o        = 1'bx;
                      ASel_o        = 0; //Reg
                      BSel_o        = 0; //Reg
                      ALUSel_o      = `ALUsra;
                      MemR_o        = 0;
                      MemW_o        = 0;
                      RegWEn_o      = 1;
                      WBSel_o       = 2'b01; //ALU
                  end
              endcase
          3'b110: //or
              begin
                  PCSel_o           = 0; //PC=PC+4
                  ImmSel_o          = `ImmSelR;
                  // BrUn_o            = 1'bx;
                  ASel_o            = 0; //Reg
                  BSel_o            = 0; //Reg
                  ALUSel_o          = `ALUor;
                  MemR_o            = 0;
                  MemW_o            = 0;
                  RegWEn_o          = 1;
                  WBSel_o           = 2'b01; //ALU
              end
          3'b111: //and
              begin
                  PCSel_o           = 0; //PC=PC+4
                  ImmSel_o          = `ImmSelR;
                  // BrUn_o            = 1'bx;
                  ASel_o            = 0; //Reg
                  BSel_o            = 0; //Reg
                  ALUSel_o          = `ALUand;
                  MemR_o            = 0;
                  MemW_o            = 0;
                  RegWEn_o          = 1;
                  WBSel_o           = 2'b01; //ALU
              end
          endcase
      `IMM_I:
        begin
          case (funct3_i)
            'h0: begin  //addi
              PCSel_o               = 0; //PC=PC+4
              ImmSel_o              = `ImmSelI; //Immediate type I
              // BrUn                = 1'bx;
              ASel_o                = 0; //Reg
              BSel_o                = 1; //Imm
              ALUSel_o              = `ALUadd;
              MemR_o                = 0;
              MemW_o                = 0;
              RegWEn_o              = 1;
              WBSel_o               = 2'b01; //ALU
            end
            'h4: begin //xori
              PCSel_o               = 0; //PC=PC+4
              ImmSel_o              = `ImmSelI; //Immediate type I
              // BrUn                = 1'bx;
              ASel_o                = 0; //Reg
              BSel_o                = 1; //Imm
              ALUSel_o              = `ALUxor;
              MemR_o                = 0;
              MemW_o                = 0;
              RegWEn_o              = 1;
              WBSel_o               = 2'b01; //ALU
            end
            'h6: begin //ori 
              PCSel_o               = 0; //PC=PC+4
              ImmSel_o              = `ImmSelI; //Immediate type I
              // BrUn                = 1'bx;
              ASel_o                = 0; //Reg
              BSel_o                = 1; //Imm
              ALUSel_o              = `ALUor;
              MemR_o                = 0;
              MemW_o                = 0;
              RegWEn_o              = 1;
              WBSel_o               = 2'b01; //ALU
            end
            'h7: begin //andi
              PCSel_o               = 0; //PC=PC+4
              ImmSel_o              = `ImmSelI; //Immediate type I
              // BrUn                = 1'bx;
              ASel_o                = 0; //Reg
              BSel_o                = 1; //Imm
              ALUSel_o              = `ALUand;
              MemR_o                = 0;
              MemW_o                = 0;
              RegWEn_o              = 1;
              WBSel_o               = 2'b01; //ALU
            end
            'h1: begin //slli
              PCSel_o               = 0; //PC=PC+4
              ImmSel_o              = `ImmSelI; //Immediate type I
              // BrUn                = 1'bx;
              ASel_o                = 0; //Reg
              BSel_o                = 1; //Imm
              ALUSel_o              = `ALUsll;
              MemR_o                = 0;
              MemW_o                = 0;
              RegWEn_o              = 1;
              WBSel_o               = 2'b01; //ALU
            end
          endcase
        end
      `LOAD_I:
          begin
              PCSel_o               = 0; //PC=PC+4
              ImmSel_o              = `ImmSelI; //Immediate type I
              BrUn_o                = 1'bx;
              ASel_o                = 0; //Reg
              BSel_o                = 1; //Imm
              ALUSel_o              = `ALUadd;
              MemR_o                = 1;
              MemW_o                = 0;
              RegWEn_o              = 1;
              WBSel_o               = 2'b00; //Mem
              end
      `S:
          begin
              PCSel_o               = 0; //PC=PC+4
              ImmSel_o              = `ImmSelS; //Immediate type S
              BrUn_o                = 1'bx;
              ASel_o                = 0; //Reg
              BSel_o                = 1; //Imm
              ALUSel_o              = `ALUadd;
              MemR_o                = 0;
              MemW_o                = 1;
              RegWEn_o              = 0;
              WBSel_o               = 2'bxx;
              end
      `B:
          case(funct3_i)
          3'b000: //beq // Branchcomp block read BrEq_i and change PCSel_o
              begin
                  PCSel_o           = (BrEq_i) ? 1 : 0; //PC=PC+Imm when Eq, PC= PC+4 when not Eq
                  ImmSel_o          = `ImmSelB; //Immediate type `B
                  // BrUn_o            = 1'bx;
                  ASel_o            = 1; //PC
                  BSel_o            = 1; //Imm
                  ALUSel_o          = `ALUadd;
                  MemR_o            = 0;
                  MemW_o            = 0;
                  RegWEn_o          = 0;
                  WBSel_o           = 2'bxx;
              end
          3'b001: //bne //Branchcomp read BrEq_i and change PCSel_o
              begin
                  PCSel_o           = (BrLT_i) ? 0 : 1; //ALU // temporary value
                  ImmSel_o          = `ImmSelB; //Immediate type `B
                  // BrUn_o            = 1'bx;
                  ASel_o            = 1; //PC
                  BSel_o            = 1; //Imm
                  ALUSel_o          = `ALUadd;
                  MemR_o            = 0;
                  MemW_o            = 0;
                  RegWEn_o          = 0;
                  WBSel_o           = 2'bxx;
              end
          3'b100: //blt //Branchcomp read BrLT_i and change PCSel_o
              begin
                  PCSel_o           = (BrLT_i) ? 1 : 0; //PC+4 // temporary value
                  ImmSel_o          = `ImmSelB; //Immediate type `B
                  BrUn_o            = 0;
                  ASel_o            = 1; //PC
                  BSel_o            = 1; //Imm
                  ALUSel_o          = `ALUadd;
                  MemR_o            = 0;
                  MemW_o            = 0;
                  RegWEn_o          = 0;
                  WBSel_o           = 2'bxx;
              end
          3'b101: //bge 
              begin
                  PCSel_o           = (BrGe_i) ? 1 : 0; //PC+4 // temporary value
                  ImmSel_o          = `ImmSelB; //Immediate type `B
                  BrUn_o            = 0;
                  ASel_o            = 1; //PC
                  BSel_o            = 1; //Imm
                  ALUSel_o          = `ALUadd;
                  MemR_o            = 0;
                  MemW_o            = 0;
                  RegWEn_o          = 0;
                  WBSel_o           = 2'bxx;
              end
          3'b101: //bltu //Branchcomp read BrLT_i and change PCSel_o
              begin
                  PCSel_o           = (BrLT_i) ? 1 : 0; //PC+4 // temporary value
                  ImmSel_o          = `ImmSelB; //Immediate type `B
                  BrUn_o            = 1;
                  ASel_o            = 1; //PC
                  BSel_o            = 1; //Imm
                  ALUSel_o          = `ALUadd;
                  MemR_o            = 0;
                  MemW_o            = 0;
                  RegWEn_o          = 0;
                  WBSel_o           = 2'bxx;
              end
          3'b111: //bgeu 
              begin
                  PCSel_o           = (BrGe_i) ? 1 : 0; //PC+4 // temporary value
                  ImmSel_o          = `ImmSelB; //Immediate type `B
                  BrUn_o            = 1;
                  ASel_o            = 1; //PC
                  BSel_o            = 1; //Imm
                  ALUSel_o          = `ALUadd;
                  MemR_o            = 0;
                  MemW_o            = 0;
                  RegWEn_o          = 0;
                  WBSel_o           = 2'bxx;
              end
          endcase
      `JUMP_I:
          begin
              PCSel_o               = 2; //jump_pc
              ImmSel_o              = `ImmSelI; //Immediate type I
              // BrUn_o                = 1'bx;
              ASel_o                = 0; //Reg
              BSel_o                = 1; //Imm
              ALUSel_o              = `ALUadd;
              MemR_o                = 0;
              MemW_o                = 0;
              RegWEn_o              = 1;
              WBSel_o               = 2'b10; // PC+4
          end
      `J:
          begin
              PCSel_o               = 0; //jump_pc
              ImmSel_o              = `ImmSelJ; //Immediate type J
              ASel_o                = 1; //PC
              BSel_o                = 1; //Imm
              ALUSel_o              = `ALUadd;
              MemR_o                = 0;
              MemW_o                = 0;
              RegWEn_o              = 1;
              WBSel_o               = 2'b10; // PC+4
          end
      `U:
          begin
              PCSel_o               = 0; //PC+4
              ImmSel_o              = `ImmSelU; //Immediate type U
              BrUn_o                = 1'bx;
              ASel_o                = 1; //PC
              BSel_o                = 1; //Imm
              ALUSel_o              = `ALUadd;
              MemR_o                = 0;
              MemW_o                = 0;
              RegWEn_o              = 1;
              WBSel_o               = 2'b01; // ALU
          end

      default: 
        begin
              PCSel_o                 = 0; //PC+4
              ImmSel_o              = 4'b1111;
              BrUn_o                = 0;
              ASel_o                = 0; //PC
              BSel_o                = 1; //Imm
              ALUSel_o              = `ALUnop;
              MemR_o                = 0;
              MemW_o                = 0;
              RegWEn_o              = 0;
              WBSel_o               = 2'b01; // ALU
        end
      endcase
  end
endmodule

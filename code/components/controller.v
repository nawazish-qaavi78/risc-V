
// controller.v - controller for RISC-V CPU

module controller (
    input  [6:0]  op,
    input  [2:0]  funct3,
    input         funct7b5,
    input  [3:0]  flags,
    output [1:0]  ResultSrc, PCSrc, 
    output        MemWrite,
    output        ALUSrc,
    output        RegWrite, Jump,
    output [2:0]  ImmSrc,
    output [3:0]  ALUControl
);

wire [1:0] ALUOp;
wire       Branch;
wire 		  PCSrc1;


main_decoder    md (op, ResultSrc, MemWrite, Branch,
                    ALUSrc, PCSrc1, RegWrite, Jump, ImmSrc, ALUOp);

alu_decoder     ad (op[5], funct3, funct7b5, ALUOp, ALUControl);

PCSrc_Decoder   PCSrcD (Jump, Branch, PCSrc1, funct3, flags, PCSrc);

endmodule


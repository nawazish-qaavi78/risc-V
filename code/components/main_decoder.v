// main_decoder.v - logic for main decoder

module main_decoder (
    input  [6:0] op,
    output [1:0] ResultSrc,
    output       MemWrite, Branch, ALUSrc, PCSrc1,
    output       RegWrite, Jump,
    output [2:0] ImmSrc,
    output [1:0] ALUOp
);

reg [12:0] controls;

// additional signals PCSrc1, and additional bit is added to ImmSrc
always @(*) begin
	 
    casez (op)
        // RegWrite_ImmSrc_ALUSrc_MemWrite_ResultSrc_Branch_ALUOp_Jump_PCSrc1
        7'b00000??: controls = 13'b1_000_1_0_01_0_00_0_0; // lw
        7'b01000??: controls = 13'b0_001_1_1_00_0_00_0_0; // sw
        7'b01100??: controls = 13'b1_000_0_0_00_0_10_0_0; // R–type
        7'b11000??: controls = 13'b0_010_0_0_00_1_01_0_0; // beq
        7'b00100??: controls = 13'b1_000_1_0_00_0_10_0_0; // I–type ALU
        7'b???1???: controls = 13'b1_011_0_0_10_0_00_1_0; // jal
		  
		  7'b0?101??: controls = 13'b1_100_0_0_11_0_00_0_0; // auipc, lui
		  7'b11001??: controls = 13'b1_000_1_0_10_0_00_0_1; // jalr
		  
        default:    controls = 13'b0; // ???
    endcase
end

assign {RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUOp, Jump, PCSrc1} = controls;


endmodule
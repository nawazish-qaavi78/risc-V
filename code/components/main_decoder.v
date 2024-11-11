
// main_decoder.v - logic for main decoder

module main_decoder (
    input  [6:0] op,
    output [1:0] ResultSrc,
    output       MemWrite, Branch, ALUSrc, PCSrc1,
    output       RegWrite, Jump,
    output [2:0] ImmSrc,
    output [1:0] ALUOp
);

reg [8:0] controls;

// additional signals PCSrc1, and additional bit is added to ImmSrc
always @(*) begin
	 
    casez (op)
        // RegWrite_ImmSrc_ALUSrc_MemWrite_ResultSrc_ALUOp
        7'b0000011: controls = 9'b1_000_1_01_00; // lw
        7'b0100011: controls = 9'b0_001_1_00_00; // sw
        7'b0110011: controls = 9'b1_xxx_0_00_10; // R–type
        7'b1100011: controls = 9'b0_010_0_00_01; // beq
        7'b0010011: controls = 9'b1_000_1_00_10; // I–type ALU
        7'b1101111: controls = 9'b1_011_0_10_00; // jal
		  
		  7'b0?10111: controls = 9'b1_100_x_11_xx; // auipc, lui
		  7'b1100111: controls = 9'b1_000_1_10_00; // jalr
		  
        default:    controls = 9'bx_xxx_x_xx_xx; // ???
    endcase
end


assign PCSrc1 = (op == 7'b1100111);
assign Jump = (op == 7'b1101111);
assign Branch = (op  == 7'b1100011);
assign MemWrite = (op == 7'b0100011);

assign {RegWrite, ImmSrc, ALUSrc, ResultSrc, ALUOp} = controls;


endmodule


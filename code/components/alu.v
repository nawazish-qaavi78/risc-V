// alu.v - ALU module

module alu #(parameter WIDTH = 32) (
    input       [WIDTH-1:0] a, b,       // operands
    input       [3:0] alu_ctrl,         // ALU control
    output reg  [WIDTH-1:0] alu_out,    // ALU output
    output      [3:0] flags                   // flag
);

wire zero, sign, carry, overflow;

always @(*) begin
    case (alu_ctrl)
        4'b0000:  alu_out <= a + b;       // ADD
        4'b0001:  alu_out <= a - b;       // SUB
        4'b0010:  alu_out <= a & b;       // AND
        4'b0011:  alu_out <= a | b;       // OR
		  4'b0100:  alu_out <= a ^ b;		   // XOR
        4'b0101:  alu_out <= $signed(a)< $signed(b); 
		  4'b0110:  alu_out <= a >> b[4:0];
		  4'b0111:  alu_out <= $signed(a) >>> b[4:0];
		  4'b1000:  alu_out <= a << b[4:0];
		  4'b1001:	alu_out <= a<b;
        default:  alu_out <= 0;
    endcase
end

assign zero = (alu_out == 0);
assign sign = alu_out[31];

assign carry = ((alu_ctrl == 4'b0000) && b[31]) || ((alu_ctrl == 4'b0001) && (a < b)); 
					
assign overflow = (alu_out[31] != a[31]) && (alu_ctrl[3:1] == 3'b000) && (alu_ctrl[0] ^ (a[31] == b[31]));

						
assign flags = {zero, sign, carry, overflow};


endmodule
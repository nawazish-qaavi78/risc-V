
// alu.v - ALU module

module alu #(parameter WIDTH = 32) (
    input       [WIDTH-1:0] a, b,       // operands
    input       [3:0] alu_ctrl,         // ALU control
    output reg  [WIDTH-1:0] alu_out,    // ALU output
    output      zero                    // zero flag
);

always @(a, b, alu_ctrl) begin
    case (alu_ctrl)
        4'b0000:  alu_out <= a + b;       // ADD
        4'b0001:  alu_out <= a + ~b + 1;  // SUB
        4'b0010:  alu_out <= a & b;       // AND
        4'b0011:  alu_out <= a | b;       // OR
		  4'b0100:  alu_out <= a ^ b;		  // XOR

        4'b0101:  begin                   // SLT  also given to less than so check for that later
		  // thsi is for signed
                     if (a[31] != b[31]) alu_out <= a[31]; // if a is -ve then a[31] = 1 => true
                     else alu_out <= a < b ? 1 : 0; 
                 end
		  // should look into actually what these are doing		  
		  4'b0110:  alu_out <= a >> b[4:0];
		  4'b0111:  alu_out <= a >>> b[4:0];
		  4'b1000:  alu_out <= a << b[4:0];
		  4'b1001:	alu_out <= a<b ? 1: 0; // this is for unsigned
        default: alu_out = 0;
    endcase
end

assign zero = (alu_out == 0) ? 1'b1 : 1'b0;

endmodule


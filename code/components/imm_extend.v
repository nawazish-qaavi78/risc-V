// imm_extend.v - logic for sign extension (optimized for resource utilization)
module imm_extend (
    input  [31:7]     instr,
    input  [ 2:0]     immsrc,
    output reg [31:0] immext
);

localparam I_TYPE   = 3'b000;
localparam S_TYPE   = 3'b001;
localparam B_TYPE   = 3'b010;
localparam J_TYPE   = 3'b011;
localparam U_TYPE   = 3'b100;

always@(*) begin
    case (immsrc)
        I_TYPE:   immext = { {20{instr[31]}}, instr[31:20] };
        S_TYPE:   immext = { {20{instr[31]}}, instr[31:25], instr[11:7] };
        B_TYPE:   immext = { {20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0 };
        J_TYPE:   immext = { {12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0 };
        U_TYPE:   immext = { instr[31:12], 12'b0 }; // No sign extension needed for U-type
		  default:  immext = 32'bx;
    endcase
end

endmodule

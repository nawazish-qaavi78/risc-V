
// slicer.v - logic for read data slicing
module slicer (
    input  [31:0]     RD,
    input  [ 2:0]     funct3,
    output reg [31:0] RDSlicer
);

always @(*) begin
    case(funct3)
        3'b000:  RDSlicer = { {24{RD[31]}}, RD[7:0]} ; // SignExt([Address]7:0)
		  3'b001:  RDSlicer = { {16{RD[31]}}, RD[15:0]}; // SignExt([Address]15:0)
		  3'b010:  RDSlicer = RD; // rd = [Address]31:0
		  
		  3'b100:  RDSlicer = { 24'b0, RD[7:0]}; // ZeroExt([Address]7:0)
		  3'b101:  RDSlicer = { 16'b0, RD[15:0]}; // ZeroExt([Address]15:0)
        default: RDSlicer = 32'bx; // undefined
    endcase
end


endmodule

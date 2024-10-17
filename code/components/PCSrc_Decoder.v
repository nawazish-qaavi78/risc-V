// PCSrc_Decoder.v - for decoding the PCSrc control signal

module PCSrc_Decoder (
	 input  		   Jump,
	 input 			Branch,
	 input 			PCSrc1,
    input  [2:0]  funct3,
    input  [3:0]  flags,
	 
    output [1:0]  PCSrc
);


reg  PCSrc0; 

wire Zero, Carry, Sign , Overflow;

// using the flags to generate the control signal for the PC decoder
always@(*) begin
	if(Jump) PCSrc0 <= 1;
	else if(Branch)
		case(funct3)
			3'b000:  PCSrc0 <= Zero;
			3'b001:  PCSrc0 <= ~Zero;
			3'b100:	PCSrc0 <= (Sign != Overflow);
			3'b101:	PCSrc0 <= (Sign == Overflow);
			3'b110:	PCSrc0 <= Carry;
			3'b111:	PCSrc0 <= ~Carry;
			default: PCSrc0 <= 0;
		endcase
	else PCSrc0 <= 0;
end

assign {Zero, Sign, Carry, Overflow} = flags;

assign PCSrc = {PCSrc1, PCSrc0};

endmodule
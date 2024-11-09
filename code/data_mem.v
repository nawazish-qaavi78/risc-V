
// data_mem.v - data memory

module data_mem #(parameter DATA_WIDTH = 32, ADDR_WIDTH = 32, MEM_SIZE = 64) (
    input       clk, wr_en,
	 input 		 [2:0] funct3,
    input       [ADDR_WIDTH-1:0] wr_addr, wr_data,
    output reg  [DATA_WIDTH-1:0] rd_data_mem
);

// array of 64 32-bit words or data
reg [DATA_WIDTH-1:0] data_ram [0:MEM_SIZE-1];

wire [ADDR_WIDTH-1:0] word_addr = wr_addr[DATA_WIDTH-1:2] % 64;

wire [4:0] byte_offset;
wire [3:0] half_word_offset;

assign byte_offset      = wr_addr[1:0]<<3;
assign half_word_offset = wr_addr[1]<<4;


// synchronous write logic
always @(posedge clk) begin
    if (wr_en) begin 
	 // decoding funct3 to perform right write operation
		case(funct3)
			3'b000: data_ram[word_addr][byte_offset+: 8]  <= wr_data[7:0];//sb
			3'b001: data_ram[word_addr][half_word_offset+:16] <= wr_data[15:0]; // sh
			3'b010: data_ram[word_addr] <= wr_data; // sw
		endcase
		
	 end
end


always @(*) begin
// decoding funct3 to perform right read operation
   case(funct3)
	   3'b000: rd_data_mem <= {{24{data_ram[word_addr][byte_offset +  7]}}, data_ram[word_addr][byte_offset+: 8]}; // lb
		3'b001: rd_data_mem <= {{16{data_ram[word_addr][half_word_offset + 15]}}, data_ram[word_addr][half_word_offset+:16]}; // lh
		3'b010: rd_data_mem <= data_ram[word_addr]; // lw
		3'b100: rd_data_mem <= {24'b0, data_ram[word_addr][byte_offset+: 8]};//lbu
		3'b101: rd_data_mem <= {16'b0, data_ram[word_addr][half_word_offset+:16]};//  lhu
		default: rd_data_mem <= 32'bx;
	endcase
end



endmodule




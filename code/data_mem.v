
// data_mem.v - data memory

module data_mem #(parameter DATA_WIDTH = 32, ADDR_WIDTH = 32, MEM_SIZE = 64) (
    input       clk, wr_en,
	 input 		 [2:0] funct3,
    input       [ADDR_WIDTH-1:0] wr_addr, wr_data,
    output reg  [DATA_WIDTH-1:0] rd_data_mem
);

// array of 64 32-bit words or data
reg [DATA_WIDTH-1:0] data_ram [0:MEM_SIZE-1];

wire [ADDR_WIDTH-1:0] word_addr = wr_addr[DATA_WIDTH-1:2] % MEM_SIZE;

wire [1:0] byte_select;
wire       half_select;

assign byte_select = wr_addr[1:0];
assign half_select =   wr_addr[1];


reg [DATA_WIDTH-1:0] write_mask;

always @(*) begin
    case (funct3)
        3'b000: write_mask = (byte_select == 2'b00) ? 32'h000000FF :
                              (byte_select == 2'b01) ? 32'h0000FF00 :
                              (byte_select == 2'b10) ? 32'h00FF0000 :
                                                       32'hFF000000;
        3'b001: write_mask = (half_select == 1'b0) ? 32'h0000FFFF : 32'hFFFF0000;
        3'b010: write_mask = 32'hFFFFFFFF;
        default: write_mask = 32'h00000000;
    endcase
end

// synchronous write logic
always @(posedge clk) begin
    if (wr_en) begin
        case (funct3)
            // Store byte (sb): Write only the first 8 bits of wr_data to the selected byte
            3'b000: data_ram[word_addr] <= (data_ram[word_addr] & ~write_mask) |
                                           ({4{wr_data[7:0]}} & write_mask);

            // Store halfword (sh): Write only the first 16 bits of wr_data to the selected halfword
            3'b001: data_ram[word_addr] <= (data_ram[word_addr] & ~write_mask) |
                                           ({2{wr_data[15:0]}} & write_mask);

            // Store word (sw): Write all 32 bits of wr_data
            3'b010: data_ram[word_addr] <= wr_data;

            // Default case: Do nothing (optional, in case synthesis tools generate warnings)
            default: data_ram[word_addr] <= data_ram[word_addr];
			endcase
    end
end


always @(*) begin
// decoding funct3 to perform right read operation
   case(funct3)
		// lb
	   3'b000: begin
			case(byte_select)
				2'b00: rd_data_mem <= {{24{data_ram[word_addr][7]}},  data_ram[word_addr][7:0]};
				2'b01: rd_data_mem <= {{24{data_ram[word_addr][15]}}, data_ram[word_addr][15:8]};
				2'b10: rd_data_mem <= {{24{data_ram[word_addr][23]}}, data_ram[word_addr][23:16]};
				2'b11: rd_data_mem <= {{24{data_ram[word_addr][31]}}, data_ram[word_addr][31:24]};
			endcase
		end
		
		3'b001: begin
			case(half_select)
				1'b0: rd_data_mem <= {{16{data_ram[word_addr][15]}}, data_ram[word_addr][15:0]}; // lh
				1'b1: rd_data_mem <= {{16{data_ram[word_addr][31]}}, data_ram[word_addr][31:16]}; // lh
			endcase
		end
		
		3'b010: rd_data_mem <= data_ram[word_addr]; // lw
		
		3'b100: begin
			case(byte_select)
				2'b00: rd_data_mem <= {24'b0, data_ram[word_addr][7:0]};
				2'b01: rd_data_mem <= {24'b0, data_ram[word_addr][15:8]};
				2'b10: rd_data_mem <= {24'b0, data_ram[word_addr][23:16]};
				2'b11: rd_data_mem <= {24'b0, data_ram[word_addr][31:24]};
			endcase
		end 
		
		3'b101: begin
			case(half_select)
				1'b0: rd_data_mem <= {16'b0, data_ram[word_addr][15:0]};//  lhu
				1'b1: rd_data_mem <= {16'b0, data_ram[word_addr][31:16]};//  lhu
			endcase
		end 
		
		default: rd_data_mem <= 32'bx;
	endcase
end



endmodule




module instructionMemory_m(
	output reg [31:0] instruction, 
	input[31:0] PC);

	reg[31:0] instruction_memory[1023:0];//creates an array that holds 1024 32-bit registers and initializes them to 0
	integer i;
	initial begin
		for (i = 0; i < 1024; i = i + 1) begin 
			instruction_memory[i] <= 32'b0; 
		end
	end

	initial begin
		instruction_memory[0] = 11111000010_000000000_00_10100_00001;
		instruction_memory[1] = 10001011000_00001_000000_00001_00010;
		instruction_memory[2] = 1101000100_000000000000_11001_10011;
		instruction_memory[3] = 10110100_0000000000000000111_00011;
		instruction_memory[4] = 11111000000_111110100_00_10100_00001;
		instruction_memory[5] = 10111111111111111111111111010;

	end

	always@(PC) begin
		instruction <= instruction_memory[PC/4];
	end

endmodule
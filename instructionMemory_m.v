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
		// Test cases for testing register and data memory
		/**
		//instruction = 1001000100_000000001000_00001_00001;
		instruction_memory[0] <= 'h91002021; //ADDI X1, X1, #8
		//instruction = 11111000000_000000000_00_00010_00001; 
		instruction_memory[1] <= 'hF8000041; //STR X1, [X2, #0];
		//instruction = 11111000010_000000000_00_00010_00011;
		instruction_memory[2] <= 'hF8400043; //LDR X3, [X2, #0];
		//instruction = 1101000100_000000000111_00011_00011;
		instruction_memory[3] <= 'hD1001C63; //SUBI X3, X3, #7;
		**/

		//Test cases from assignment
		//instruction = 11111000010_000000000_00_10100_00001;
		instruction_memory[0] <= 'hF8400281; // LDR X1, [X20, #0]
		//instruction = 10001011000_00001_000000_00001_00010;
		instruction_memory[1] <= 'h8B010022; //ADD X2, X1, X1;
		//instruction = 1101000100_000000000000_11001_10011;
		instruction_memory[2] <= 'hD1000333; //SUBI X19, X25, #0
		//instruction = 10110100_0000000000000000111_00011;
		instruction_memory[3] <= 'hB40000E3; //CBZ X3, #7
		//instruction = 1001000100_000000001000_10100_10100;
		instruction_memory[10] <= 'h91002294; //ADDI X20, X20, #8
		//instruction = 11111000000_000000000_00_10100_00001;
		instruction_memory[11] <= 'b11111000000_000000000_00_10100_10100; //STR X20, [X20, #0]
		//instruction = 000101_11111111111111111111110100;
		instruction_memory[12] <= 'b000101_11111111111111111111110100; //B , #-12

		//More test cases
		/**
		//instruction = 000101_11111111111111111111111111
		instruction = 32'h17FFFFFF; //B #-1
		//instruction = 100101_00001000000010000000000010
		instruction_memory[0] <= 'h94202002; // BL #2105346
		//instruction = 10110100_0010110100111001010_00101
		instruction_memory[1] <= 'hB42D3945; //CBZ X5, #92618
		//instruction = 10110101_1101001011000110110_00011
		instruction_memory[2] <= 'hB5D2C6C3; //CBNZ X3, #-92618
		//instruction = 10001010000_00100_000000_00010_00001
		instruction_memory[3] <= 'h8A040041; //AND X1, X2, X4 
		//instruction = 11111000000_110111000_00_00010_00100  
		instruction_memory[4] <= 'hF81B8044; //STR X4, [X2, #-72]
		//instruction = 11111000010_001100010_00_00011_00000
		instruction_memory[5] <= 'hF8462060; //LDR X0, [X3, #98]
		//instruction = 1001000100_111110000000_11111_00000
		instruction_memory[6] <= 'h913E03E0; //ADDI X0, XZR, #-128
		//instruction = 111100101_13 bits_00111_00010 
		instruction_memory[7] <= 'hF28000E2; //MOVE X2, X7
		**/
	end

	always@(PC) begin
		instruction <= instruction_memory[PC/4];
	end

endmodule
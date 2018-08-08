/*
 * Creates an array to store all the 32-bit instructions. The array is preloaded and will output 
 * an instruction based on the PC. By default an instruction will be 32'b0 (no-op).
 */ 

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
		//All together now
		/**
		instruction_memory[0] <= 'b1001000100_000000000100_11111_00000; //ADDI XO, XZR, #4
		instruction_memory[1] <= 'b1001000100_010100000000_11111_00001; //ADDI XZR, X1, #1280
		instruction_memory[2] <= 'b11111000010_00000000000_00001_00010; //LDUR X2, [X2, #0]
		instruction_memory[3] <= 'b11111000010_00001000000_00001_00011; //LDUR X3, [X1, #16]
		instruction_memory[4] <= 'b1000101100_000011000000_00010_00100; //ADD X4, X2, X3
		instruction_memory[5] <= 'b11111000000_00000000000_00001_00100; //STR Z4, [X1, #0]
		instruction_memory[6] <= 'b1001000100_000000001000_00001_00001; //ADDI X1, X1, #8
		instruction_memory[7] <= 'b1101000100_000000000001_00000_00000; //SUBI X0, X0, #1
		instruction_memory[8] <= 'b10110101_1111111111111111010_00000; //CBNZ X0, #-6
		instruction_memory[9] <= 'b11001011000_00101_000000_00101_00101; //SUBI X5, X5, X5
		**/
		
		//Test cases from the Verilog Processor assignment
		//instruction = 11111000010_000000000_00_10100_00001
		instruction_memory[0] <= 'hF8400281; //LDR X1, [X20, #0]
		//instruction = 10001011000_00001_000000_00001_00010 
		instruction_memory[1] <= 'h8B010022; // ADD X2, X1, X1
		//instruction = 1101000100_000000000000_11001_10011
		instruction_memory[2] <= 'hD1000333; // SUBI X19, X25, #0
		//instruction = 10110100_0000000000000000111_00011
		instruction_memory[3] <= 'hB40000E3; // CBZ X3, #7
		//instruction = 1001000100_000000001000_10100_10100
		instruction_memory[10] <= 'h91002294; // ADDI X20, X20, #8
		//instruction = 11111000000_111110100_00_10100_00001
		instruction_memory[11] <= 'hF81F4281; // STR X1, [X20, #-12]
		//instruction = 10111111111111111111111111010
		instruction_memory[12] <= 'h17FFFFFA; // B #-6

		//Test cases from assignment 5
		/**
		instruction_memory[0] <= 'b000101_00000000000000000000000011; //B #3
		instruction_memory[3] <= 'b100101_11111111111111111111111110; // BL #-2
		instruction_memory[1] <= 'b10110100_0000000000000001000_00101; //CBZ X5, #8
		instruction_memory[9] <= 'b10110101_1101001011000110110_00011; //CBNZ X3, #-92618
		instruction_memory[10] <= 'b10001010000_00100_000000_00010_00001; //AND X1, X2, X4 
		instruction_memory[11] <= 'b11111000000_110111000_00_00010_00100; //STR X4, [X2, #-72]
		instruction_memory[12] <= 'b11111000010_001100010_00_00011_00000; //LDR X0, [X3, #98]
		instruction_memory[13] <= 'b1001000100_111110000000_11111_00000; //ADDI X0, XZR, #-128
		instruction_memory[14] <= 'b111100101_0000000000000_00111_00010; //MOVE X2, X7
		**/
		
		// Test cases for testing register and data memory
		/**
		//instruction = 1001000100_000000001000_00001_00001;
		instruction_memory[0] <= 'h91002021; //ADDI X1, X1, #8
		//instruction = 11111000000_000000011_00_00010_00001; 
		instruction_memory[1] <= 'hF8003041; //STR X1, [X2, #3];
		//instruction = 11111000010_000000011_00_00010_00011;
		instruction_memory[2] <= 'hF8403043; //LDR X3, [X2, #3];
		//instruction = 1101000100_000000000111_00011_00011;
		instruction_memory[3] <= 'hD1001C63; //SUBI X3, X3, #7;
		**/

		// Test cases for XZR and overflow
		/**
		instruction_memory[0] <= 32'b1001000100_000000001010_11111_11111; //ADDI XZR, XZR, #10
		instruction_memory[1] <= 32'b1001000100_000000000001_11111_00001 ;//ADDI X1, XZR, #1
		instruction_memory[2] <= 32'b10001011000_00010_000000_00011_00100 ; //ADD X4, X3, X2;
		**/
	end

	always@(PC) begin
		instruction <= instruction_memory[PC/4];
	end
endmodule
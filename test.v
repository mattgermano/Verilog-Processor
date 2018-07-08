`include "decoder_m.v"
`include "registers_m.v"
`timescale 1ns / 1ps

module test();

	//Inputs
	//Decoder
	reg[31:0] instruction;

	//Registers
	reg[31:0] writeData;

	//Outputs
	//Decoder
	wire Reg2Loc, Uncondbranch, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite; 
	wire [1:0] ALUOp;
	wire [4:0] register1, register2, writeRegister;
	wire signed[31:0] immediate;

	//Registers
	wire[31:0] data1, data2;

	//Instantiate an object from the decoder class
	decoder_m decoder(register1, register2, writeRegister, immediate, Reg2Loc,
			Uncondbranch, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, ALUOp, instruction);

	//Instantiate an object from the register class
	registers_m register(data1, data2, writeData, register1, register2, writeRegister, immediate, RegWrite, ALUSrc);

	//Create a waveform file
	initial begin
		$dumpfile("waveform.vcd");
		$dumpvars(0, test);
	end

	//monitors variables
	initial begin
        $monitor("instruction: %b", instruction,
			"\tregister1: %b", register1,
			"\tregister2: %b", register2,
			"\twrite_register: %b", writeRegister,
			"\timmediate: %d", immediate,
			"\tReg2Loc: %b", Reg2Loc,
			"\tUnconbranch: %b", Uncondbranch,
			"\tbranch: %b", Branch,
			"\tMemRead: %b", MemRead,
			"\tMemWrite: %b", MemWrite,
			"\tMemToReg: %b", MemtoReg,
			"\tALUSrc: %b", ALUSrc,
			"\tRegWrite: %b", RegWrite,
			"\tALUOp: %b", ALUOp,
			"\tdata1 :%b", data1,
			"\tdata2 :%b", data2); 
    end

	initial begin
		//instruction = 000101_11111111111111111111111111
		instruction = 32'h17FFFFFF; //B #-1
		//instruction = 100101_00001000000010000000000010
		#2 instruction = 32'h94202002; // BL #2105346
		//instruction = 10110100_0010110100111001010_00101
		#2 instruction = 32'hB42D3945; //CBZ X5, #92618
		//instruction = 10110101_1101001011000110110_00011
		#2 instruction = 32'hB5D2C6C3; //CBNZ X3, #-92618
		//instruction = 10001010000_00100_000000_00010_00001
		#2 instruction = 32'h8A040041; //AND X1, X2, X4 
		//instruction = 11111000000_110111000_00_00010_00100  
		#2 instruction = 32'hF81B8044; //STR X4, [X2, #-72]
		//instruction = 11111000010_001100010_00_00011_00000
		#2 instruction = 32'hF8462060; //LDR X0, [X3, #98]
		//instruction = 1001000100_111110000000_11111_00000
		#2 instruction = 32'h913E03E0; //ADDI X0, XZR, #-128
		//instruction = 111100101_13 bits_00111_00010 
		#2 instruction = 32'hF28000E2; //MOVE X2, X7
	end

	/** Test cases from project assignment
	initial begin
		//instruction = 11111000010_000000000_00_10100_00001;
		instruction = 'hF8400281; // LDR X1, [X20, #0]
		//instruction = 10001011000_00001_000000_00001_00010;
		#2 instruction = 'h8B010022; ADD X2, X1, X1;
		//instruction = 1101000100_000000000000_11001_10011;
		#2 instruction = 'hD1000333; //SUBI X19, X25, #0
		//instruction = 10110100_0000000000000000111_00011;
		#2 instruction = 'hB40000E3; //CBZ X3, #7
		//instruction = 1001000100_000000001000_10100_10100;
		#2 instruction = 'h91002294; //ADDI X20, X20, #8
		//instruction = 11111000000_111110100_00_10100_00001;
		#2 instruction = 'hF81F4281; //X1, [X20, #500]
		//instruction = 10111111111111111111111111010;
		#2 instruction = 'h17FFFFFA; // NO OP
	end
	**/
endmodule
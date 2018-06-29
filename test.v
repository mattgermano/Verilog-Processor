`include "decoder_m.v"
`timescale 1ns / 1ps

module test();

	//Inputs
	reg[31:0] instruction;

	//Outputs
	wire Reg2Loc, Uncondbranch, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite; 
	wire [1:0] ALUOp;
	wire [4:0] register1, register2, writeRegister;
	wire[25:0] immediate;

	decoder_m decoder(register1, register2, writeRegister, immediate, Reg2Loc,
			Uncondbranch, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, ALUOp, instruction);

		initial begin
			$dumpfile("waveform.vcd");
			$dumpvars(0, test);
		end

	initial begin
		$monitor("Instruction: ", "%b", instruction, "\n", "\tRegister 1: ", "%b", register1, "\tRegister 2: ", "%b", register2, 
		"\tWrite Register: ", "%b", writeRegister, "\tImmediate: ", "%d", immediate, "\n", 
		"\tReg2Loc: ", Reg2Loc, "\tUncondbranch: ", Uncondbranch, "\tBranch: ", Branch, "\tMemRead: ", MemRead, "\tMemtoReg: ", MemtoReg,
		"\tALUOp: ", ALUOp, "\tMemWrite: ", MemWrite, "\tALUSrc: ", ALUSrc, "\tRegWrite: ", RegWrite, "\n");
	end

	initial begin
		//instruction = 1001000100_000010000000_11111_00000
		instruction = 32'h910203E0;//ADDI X0,XZR, #128
		//instruction = 100100_01000000100000001111100000
		#2 instruction = 32'h14001101; //B #16909280
		//instruction = 111010_0000100000001000000000001
		#2 instruction = 32'h74101001; // BL #1052673
		//instruction = 10110100_0010110100111001010_00101
		#2 instruction = 32'hB42D3945; //CBZ X5, #92618
		//instruction = 10001010000_00100_000000_00010_00001
		#2 instruction = 32'h8A040041; //AND X1, X2, X4 
		//instruction = 11111000000_001001000_00_00010_00100  
		#2 instruction = 32'hF8048044; //STR X4, [X2, #72]
		//instruction = 11111000010_001100010_00_00011_00000
		#2 instruction = 32'hF8462060; //LDR X0, [X3, #98]
		//instruction = 111100101_13 bits_00111_00010 
		#2 instruction = 32'hF28000E2; //MOVE X2, X7
	end
endmodule
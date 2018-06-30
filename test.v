`include "decoder_m.v"
`timescale 1ns / 1ps

module test();

	//Inputs
	reg[31:0] instruction;

	//Outputs
	wire Reg2Loc, Uncondbranch, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite; 
	wire [1:0] ALUOp;
	wire [4:0] register1, register2, writeRegister;
	wire signed[31:0] immediate;

	//Instantiate an object from the decoder class
	decoder_m decoder(register1, register2, writeRegister, immediate, Reg2Loc,
			Uncondbranch, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, ALUOp, instruction);

		//Create a waveform file
		initial begin
			$dumpfile("waveform.vcd");
			$dumpvars(0, test);
		end

	initial begin
        $monitor("instruction: %b", instruction,
                 "\tregister1: %b", register1,
                 "\tregister2: %b", register2,
                 "\twrite_register: %b", writeRegister,
                 "\timmediate: %d", immediate,
                 "\tUnconbranch: %b", Uncondbranch,
                 "\tbranch: %b", Branch,
                 "\tMemRead: %b", MemRead,
                 "\tMemWrite: %b", MemWrite,
                 "\tMemToReg: %b", MemtoReg,
                 "\tALUSrc: %b", ALUSrc,
                 "\tRegWrite: %b", RegWrite,
				 "\tALUOp: %b", ALUOp
                 ); 
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
endmodule
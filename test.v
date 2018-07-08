`include "decoder_m.v"
`include "registers_m.v"
`include "ALU_m.v"
`include "ALUControl_m.v"
`include "dataMemory_m.v"
`include "multiplexer_m.v"
`include "PC_m.v"
`include "instructionMemory_m.v"
`timescale 1ns / 1ps

module test();

	wire [31:0] instruction, PC;//Instruction and PC
	wire Reg2Loc, Uncondbranch, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite; wire [1:0] ALUOp; //Control bits
	wire [4:0] register1, register2, writeRegister; //Registers
	wire signed[31:0] data1, data2, immediate; //Data from Registers/Immediate
	wire [3:0] aluControl; //ALU Control
	wire[31:0] aluResult; wire overflow, zeroflag;//ALU output
	
	wire[31:0] writeData;//The data to be written back to the registers
	wire[31:0] writeDataMem;//The data to be written to the data module
	wire[31:0] readData;//The output from the data module that goes into the RegWrite ux

	reg clock;

	//Instantiate an object from the decoder class
	decoder_m decoder(register1, register2, writeRegister, immediate, Reg2Loc,
			Uncondbranch, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, ALUOp, instruction);

	//Instantiate an object from the register class
	registers_m register(data1, data2, writeDataMem, writeData, register1, register2, writeRegister, immediate, RegWrite, ALUSrc);

	//Instantiate an object from teh ALUControl class
	ALUControl_m ALUControl(aluControl, instruction, ALUOp);

	//Instantiate an object from the ALU class
	ALU_m alu(aluResult, overflow, zeroflag, aluControl, data1, data2);

	//Instantiate an object from the dataMemory class
	dataMemory_m dataMemory(readData, aluResult, writeDataMem, MemWrite, MemRead);

	//Instantiate an object from the multiplexor class
	multiplexer_m multiplexer(writeData, readData, aluResult, MemtoReg);

	//Instantiate an object from the PC class
	PC_m PC_module(PC, immediate, Uncondbranch, Branch, zeroflag, clock);

	//Instantiate an object from the instructionMemory class
	instructionMemory_m instructionMemory(instruction, PC);


	//Create a waveform file
	initial begin
		$dumpfile("waveform.vcd");
		$dumpvars(0, test);
	end

	//monitors variables
	initial begin
        $monitor(
			"instruction: %b", instruction, "\tPC: %d", PC, 
			"\nReg2Loc: %b", Reg2Loc, "\tUnconbranch: %b", Uncondbranch,"\tbranch: %b", Branch,"\tMemRead: %b", MemRead,"\tMemWrite: %b", MemWrite,"\tMemToReg: %b", MemtoReg,"\tALUSrc: %b", ALUSrc,
			"\tRegWrite: %b", RegWrite,"\tALUOp: %b", ALUOp,
			"\nregister1: %d", register1, "\tdata1 :%d", data1, "\tregister2: %d", register2, "\tdata2 :%d", data2, "\timmediate: %d", immediate,"\twrite_register: %d", writeRegister,
			"\naluControl: %b", aluControl,"\toverflow: %d", overflow, "\taluResult: %d", aluResult,"\tzeroFlag: %b", zeroflag,"\twriteDataMem :%d", writeDataMem,
			"\nreadData: %d", readData,"\twriteData: %d", writeData, "\n");
    end

	initial begin				
		clock = 0;		
		repeat(6) begin 
			#1 clock = ~clock;
		end
	end
endmodule
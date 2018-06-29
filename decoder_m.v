module decoder_m(
	output reg[4:0] register1, output reg[4:0] register2, output reg[4:0] writeRegister, output reg[25:0] immediate,  
	output reg Reg2Loc, Uncondbranch, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, output reg[1:0] ALUOp,  
	input[31:0] instruction);

	//Run whenever the value of instruction changes
	always@(instruction) begin
		//B and BL
		if(instruction[30:26] == 5'b00101) begin
			Uncondbranch = 1; Branch = 0; MemRead = 0; MemWrite = 0; RegWrite = 0;
			immediate = instruction[25:0];
		end
		//CBZ and CBNZ
		else if(instruction[31:25] == 7'b1011010) begin 
			Reg2Loc = 1; Uncondbranch = 0; Branch = 1; MemRead = 0; MemWrite = 0; ALUSrc = 0; RegWrite = 0; ALUOp = 2'b01;
			register2 = instruction[4:0]; immediate = instruction[23:5];
		end
		//Load and Store
		else if(instruction[31:23] == 9'b111110000 && instruction[21] == 0) begin
			if(instruction[22] == 1) begin //Load
				Uncondbranch = 0; Branch = 0; MemRead = 1; MemWrite = 0; MemtoReg = 1; ALUSrc = 1; RegWrite = 1; ALUOp = 2'b00;
				writeRegister = instruction[4:0]; register1 = instruction[9:5]; immediate = instruction[21:12];
			end

			else begin //Store
				Reg2Loc = 1; Uncondbranch = 0; Branch = 0; MemRead = 0; MemWrite = 1; ALUSrc = 1; RegWrite = 0; ALUOp = 2'b00;
				register1 = instruction[9:5]; register2 = instruction[4:0]; immediate = instruction[21:12];
			end
		end
		//R-Type
		else if(instruction[31] == 1'b1 && instruction[28:25] == 4'b0101 && instruction[23:21] == 3'b000) begin
			if((~instruction[30] & ~instruction[29]) | (~instruction[29] & instruction[24]) | (instruction[29] & ~instruction[24])) begin
				Reg2Loc = 0; Uncondbranch = 0; Branch = 0; MemRead = 0; MemWrite = 0; MemtoReg = 0; ALUSrc = 0; RegWrite = 1; ALUOp = 2'b10;
				register1 = instruction[9:5]; register2 = instruction[20:16]; writeRegister = instruction[4:0]; 
			end
		end
		//I-Type
		else if(instruction[31] == 1 && instruction[28:26] == 3'b100 && instruction[23:22] == 2'b00) begin
			if((~instruction[29] & ~instruction[25] & instruction[24]) | (~instruction[30] & instruction[25] & ~instruction[24]) | (~instruction[29] & instruction[25] & ~instruction[24])) begin
				Uncondbranch = 0; Branch = 0; MemRead = 0; MemWrite = 0; MemtoReg = 0; ALUSrc = 1; RegWrite = 1; ALUOp = 2'b10;
				immediate = instruction[21:10]; writeRegister = instruction[4:0]; register1 = instruction[9:5];
			end
		end

		else if(instruction[31:23] == 9'b111100101) begin //MOV
			register1 = instruction[9:5]; writeRegister = instruction[4:0];
			Uncondbranch = 0; Branch = 0; MemRead = 0; MemWrite = 0; MemtoReg = 1; RegWrite = 1;
		end
	end
endmodule
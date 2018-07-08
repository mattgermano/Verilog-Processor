module registers_m(
	output reg signed[31:0] data1, output reg signed[31:0] data2,
	input [31:0] writeData, input[4:0] register1, input[4:0] register2, input[4:0] writeRegister, input signed[31:0]immediate, input RegWrite, input ALUSrc);

	reg[31:0] register_memory [31:0];//creates an array that holds 32 32-bit registers and initializes them to 0
	integer i;
	initial begin
		for (i = 0; i < 32; i = i + 1) begin 
			register_memory[i] <= 32'b0; 
		end
	end

	always@(*) begin
		data1 <= register_memory[(register1)];
		if(ALUSrc == 0) begin //Logic for the mux that chooses data2
			data2 <= register_memory[(register2)];
		end else begin
			data2 <= immediate;
		end
		if(RegWrite == 1) begin //if RegWrite is active
			if(writeRegister != 0) begin //makes sure to not write to XZR
				register_memory[(writeRegister)] = writeData;
			end
		end
	end
endmodule
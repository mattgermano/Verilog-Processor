module dataMemory_m(
	output reg signed[31:0] readData,
	input signed[31:0] aluResult, input signed[31:0] writeDataMem, input MemWrite, input MemRead);

	reg[31:0] data_memory [1023:0];//creates an array that holds 1024 32-bit memory blocks and initializes them to 0
	integer i;
	initial begin
		for (i = 0; i < 1024; i = i + 1) begin 
			data_memory[i] <= 32'b0; 
		end
	end

	always@* begin
		if(MemRead == 1) begin//If the instruction is a load
			if(aluResult % 4 == 0) begin
				readData <= data_memory[aluResult/4];
			end	else if(aluResult % 4 == 1) begin
				readData <= {data_memory[(aluResult-1)/4][31:8], data_memory[(aluResult+3)/4][7:0]};
			end else if(aluResult % 4 == 2) begin
				readData <= {data_memory[(aluResult-2)/4][31:16], data_memory[(aluResult+2)/4][15:0]};
			end else if(aluResult % 4 == 3) begin
				readData <= {data_memory[(aluResult-3)/4][31:24], data_memory[(aluResult+4)/4][23:0]};
			end
		end else if(MemWrite == 1) begin//If the instruction is a write
			if(aluResult % 4 == 0) begin
				data_memory[aluResult/4] <= writeDataMem;
			end else if(aluResult % 4 == 1) begin
				{data_memory[(aluResult-1)/4][31:8], data_memory[(aluResult+3)/4][7:0]} <= writeDataMem;
			end else if(aluResult % 4 == 2) begin
				{data_memory[(aluResult-2)/4][31:16], data_memory[(aluResult+2)/4][15:0]} <= writeDataMem;
			end else if(aluResult % 4 == 3) begin
				{data_memory[(aluResult-3)/4][31:24], data_memory[(aluResult+4)/4][23:0]} <= writeDataMem;
			end
		end
	end
endmodule
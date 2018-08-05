module dataMemory_m(
	output reg signed[31:0] readData,
	input signed[31:0] aluResult, input signed[31:0] writeDataMem, input MemWrite, input MemRead);

	reg[30:0] setAddress [0:1023];
	reg[31:0] setData [0:1023];

	wire [31:0] blockAddress = aluResult;
	wire [9:0] blockID  = blockAddress % 1024;

	//Initializes the setData and setAddresses to 0
	integer i;
	initial begin
		for(i = 0; i < 1024; i = i + 1) begin
			setAddress[i] <= 32'bx;
			setData[i] <= 0;
		end // for
	end // initial begin

	always@* begin
		#1
		if (setAddress[blockID] == blockAddress) begin // address is in the cache
			if (MemRead) begin // Read data from the address
				readData = setData[blockID];
			end // if
			else if (MemWrite) begin // Write data to the address 
				setData[blockID] = writeDataMem;
			end // else if
		end //if
		else begin // address is not in the cache
			if (MemWrite) begin
				setAddress[blockID] = blockAddress;
				setData[blockID] = writeDataMem;
			end // if
			else if(MemRead) begin
				setAddress[blockID] = blockAddress;
				readData = 32'bx;
			end // else if
		end // else
	end // always
endmodule
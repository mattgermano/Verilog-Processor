module dataMemory_m(
	output reg signed[31:0] readData,
	input signed[31:0] aluResult, input signed[31:0] writeDataMem, input MemWrite, input MemRead);

	reg[30:0] setAddress [0:1023];
	reg[31:0] setData [0:1023];

	/**
	* This cache is a 1024 line direct-map each line with 1 block and 
	* there are only 32 bits for the data so we have the following:
	* Byte Offset = 2 bits, Index = 0, Block Offset = 0 bit. Tag = 32 - 2 - 0 = 30.
	**/
	wire [30:0] blockAddress = aluResult[31:2];
	wire [1:0] byteOffset = aluResult[1:0];
	wire [9:0] blockID  = blockAddress % 1024;

	//Initializes the setData and setAddresses to 0
	integer i;
	integer j; // used to loop through the bits in the memory
	initial begin
		for(i = 0; i < 1024; i = i + 1) begin
			setAddress[i] <= 0;
			setData[i] <= 0;
		end // for
	end // initial begin

	always@(MemWrite || MemRead) begin
		if (setAddress[blockID] == blockAddress) begin // address is in the cache
			if (MemRead) begin // Read data from the address
				if (byteOffset != 0 ) begin // if there is a byte offset
					j = 31;
					for(i = (31 - 8*byteOffset); i >= 0; i = i - 1) begin
						readData[j] = setData[blockID][i];
						j = j - 1;
					end // for loop
					for(i = 31; i >= (31 - 8*byteOffset); i = i - 1) begin
						readData[j] = setData[blockID+1][i];
						j = j - 1;
					end // for loop
				end // if 
				else begin
				readData = setData[blockID];
				end // else
			end // if
			else if (MemWrite) begin // Write data to the address 
				setData[blockID] = writeDataMem;
			end // else if
		end //if
		else begin // address is not in the cache
			setAddress[blockID] = blockAddress;
			if (MemWrite) begin
				setData[blockID] = writeDataMem;
			end // if
			else if(MemRead) begin
				readData = 32'bx;
			end // else if
		end // else
	end // always
endmodule
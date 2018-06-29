module ALU_m(
	output reg [31:0] aluResult, output reg overflow, output reg zeroFlag, 
	input[3:0] aluControl, input [31:0] data1, input [31:0] data2);

	always@* begin
		case(aluControl)
			
		4'b0010:	{overflow, aluResult} = data1 + data2; 		//ADD, STUR, LDUR: For D-type instructions, add the immediate to the register to compute the address
		4'b1010:	{overflow, aluResult} = data1 - data2;		//SUB
		4'b0111:	zeroFlag = (data2 == 0); 					//CBZ: Compare data 2 to zero, set the zero flag to 1 if it is equal to zero
		4'b0110:	aluResult = data1 & data2;					//AND
		4'b0100:	aluResult = data1 | data2;				 	//ORR
		4'b1001:	aluResult = data1 ^ data2;			 		//EOR
		4'b0101:	aluResult = ~(data1 | data2);				//NOR
		4'b1100:	aluResult = ~(data1 & data2); 				//NAND
		4'b1101:	aluResult = data2;					 		//MOV
		default: 	aluResult = 32'bx;	 						//Default case

		endcase
	end
endmodule
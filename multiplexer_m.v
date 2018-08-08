/*
 * 2-1 Multiplexer module used to determine which data gets written back to the registers.
 * The two inputs are the aluResult and the data read from the memory. The select bit is MemToReg.
 */
module multiplexer_m(
	output reg signed[31:0] multiplexerOutput, 
	input signed[31:0] input1, input signed[31:0] input2, input select);

	always@* begin
		if(select == 1) begin
			multiplexerOutput <= input1;
		end else begin // if
			multiplexerOutput <= input2;
		end // else
	end
endmodule
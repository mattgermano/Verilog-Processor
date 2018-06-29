module multiplexer_m(
	output reg[31:0] multiplexerOutput, 
	input[31:0] input1, input[31:0] input2, input select);

	always@(input1 or input2 or select) begin
		multiplexerOutput = (~select & input1) | (select & input2);

	end

endmodule
module multiplexer_m(
	output reg signed[31:0] multiplexerOutput, 
	input signed[31:0] input1, input signed[31:0] input2, input select);

	always@* begin
		//multiplexerOutput <= (~select & input2) | (select & input1);
		if(select == 1) begin
			multiplexerOutput <= input1;
		end else begin
			multiplexerOutput <= input2;
		end
	end
endmodule
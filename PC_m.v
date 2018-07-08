module PC_m(
	output reg[31:0] PC, 
	input[31:0] nextPC, input signed[31:0] immediate, input Uncondbranch, input Branch, input zeroFlag, input clock);

	always@(posedge clock) begin
		if(((Uncondbranch | (zeroFlag & Branch)) == 1) begin
			nextPC <= PC + (immediate << 2);
		end

		else begin
			nextPC <= PC + 4;
		end
	end

endmodule
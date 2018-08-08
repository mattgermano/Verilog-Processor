module PC_m(
	output reg[31:0] PC,
	input signed[31:0] immediate, input Uncondbranch, input Branch, input zeroFlag, input clock);

	initial begin
		PC <= 0;
	end

	always@(posedge clock) begin
		if((Uncondbranch | (zeroFlag & Branch)) == 1) begin
			PC <= PC + (immediate << 2);
		end // if 
		else begin
			PC <= PC + 4;
		end // else
	end // always
endmodule
module Not(
	input in,
	output reg out);

	initial begin
		out <= 0;
	end
	
	always @(in) begin
		out <= ~in;
	end
	
endmodule
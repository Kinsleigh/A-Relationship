module Mux5Spec(
	input [4:0] in,
	input Control,
	output reg [4:0] out);

	initial begin
		out <= 0;
	end
	
	always@(*)begin
		if(Control)
			out <= 5'd31;
		else
			out <= in;
	end
	
endmodule
module Adder8Bit(
	input [7:0] In1, In2, 
	output reg [7:0] Out);
	
	initial begin
	   Out <= 0;
	end
	
	always @(In1, In2) begin
		Out <= $signed(In1) + $signed(In2);
	end
	
endmodule
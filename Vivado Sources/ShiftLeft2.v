module ShiftLeft2(
	input [31:0] In, 
	output reg [31:0] Out);
	
	initial begin
		Out <= 0;
	end
	
	always @(In) begin
		Out <= In << 2; 
	end
	
endmodule
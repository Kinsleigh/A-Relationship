module And(
	input A,B,
	output reg Out);
	
	initial begin
	   Out <= 0;
	end
	
	always @(A, B) begin
		Out <= A & B;
	end

endmodule
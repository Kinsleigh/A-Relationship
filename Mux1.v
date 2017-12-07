module Mux1(
	input A, B, Control, 
	output reg Output);
	
	initial begin
	   Output <= 0;
	end
	
	always @(*) begin
		if (Control) begin
			Output <= B;
		end
		else begin
			Output <= A;
		end
	
	end
endmodule
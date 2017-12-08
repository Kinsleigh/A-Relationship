module Mux32(
    input [31:0] A, B, 
    input Control, 
    output reg [31:0] Output);
	
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
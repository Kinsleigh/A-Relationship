module Mux32_2(
    input [31:0] A, B, C,
    input [1:0] Control, 
    output reg [31:0] Output);
	
	initial begin
	   Output <= 0;
	end
	
	always @(*) begin
		if (Control == 2)
			Output <= C;
		else if (Control == 1)
			Output <= B;
		else begin
			Output <= A;
		end
	
	end
endmodule
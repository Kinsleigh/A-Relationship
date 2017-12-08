`timescale 1ns / 1ps

module Mux2(
    input [1:0] A, 
    input Control, 
    output reg [1:0] Output);
	
	initial begin
	   Output <= 0;
	end
	
	always @(*) begin
		if (Control) begin
			Output <= 2'b0;
		end
		else begin
			Output <= A;
		end
	
	end
endmodule
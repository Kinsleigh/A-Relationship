`timescale 1ns / 1ps

module SADComparator(FirstMinSAD, FirstMinSADRow, FirstMinSADColumn, SecondMinSAD, SecondMinSADRow, SecondMinSADColumn, MinSADOut, MinSADRowOut, MinSADColumnOut);
	input [31:0] FirstMinSAD, SecondMinSAD;
	input [7:0] FirstMinSADRow, FirstMinSADColumn, SecondMinSADRow, SecondMinSADColumn;
	output reg [31:0] MinSADOut;
	output reg [7:0] MinSADRowOut, MinSADColumnOut;

	initial begin
		MinSADOut <= 32767;
		MinSADRowOut <= 0;
		MinSADColumnOut <= 0;
	end

	always @(*) begin
		if (FirstMinSAD < SecondMinSAD) begin
			MinSADOut <= FirstMinSAD;
			MinSADRowOut <= FirstMinSADRow;
			MinSADColumnOut <= FirstMinSADColumn;
		end else begin
			MinSADOut <= SecondMinSAD;
			MinSADRowOut <= SecondMinSADRow;
			MinSADColumnOut <= SecondMinSADColumn;			
		end
	end
endmodule

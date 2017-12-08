`timescale 1ns / 1ps

module SADRegister(MinSADIn, MinSADRowIn, MinSADColumnIn, MinSADOut, MinSADRowOut, MinSADColumnOut);
	input [31:0] MinSADIn;
	input [7:0] MinSADRowIn, MinSADColumnIn;
	output reg [31:0] MinSADOut;
	output reg [7:0] MinSADRowOut, MinSADColumnOut;

	initial begin
		MinSADOut <= 32767;
		MinSADRowOut <= 0;
		MinSADColumnOut <= 0;
	end

	always @(*) begin
		if (MinSADIn <= MinSADOut) begin
			MinSADOut <= MinSADIn;
			MinSADRowOut <= MinSADRowIn;
			MinSADColumnOut <= MinSADColumnIn;
		end else begin
			MinSADOut <= MinSADOut;
			MinSADRowOut <= MinSADRowOut;
			MinSADColumnOut <= MinSADColumnOut;			
		end
	end
endmodule

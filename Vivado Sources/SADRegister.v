`timescale 1ns / 1ps

module SADRegister(Clk, Rst, MinSADIn, MinSADRowIn, MinSADColumnIn, MinSADOut, MinSADRowOut, MinSADColumnOut);
	input Clk, Rst;
	input [31:0] MinSADIn;
	input [7:0] MinSADRowIn, MinSADColumnIn;
	output reg [31:0] MinSADOut;
	output reg [7:0] MinSADRowOut, MinSADColumnOut;

	initial begin
		MinSADOut <= 32767;
		MinSADRowOut <= 0;
		MinSADColumnOut <= 0;
	end
	
	always @(posedge Clk) begin
		MinSADOut <= MinSADOut;
		MinSADRowOut <= MinSADRowOut;
		MinSADColumnOut <= MinSADColumnOut;	
		
		if ((MinSADIn < MinSADOut) && Rst == 0) begin
			MinSADOut <= MinSADIn;
			MinSADRowOut <= MinSADRowIn;
			MinSADColumnOut <= MinSADColumnIn;
		end else if(Rst == 1) begin
			MinSADOut <= 32767;
			MinSADRowOut <= 0;
			MinSADColumnOut <= 0;
		end			
	end
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2017 12:21:15 PM
// Design Name: 
// Module Name: Display_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Display_tb();

	reg Clk, Rst;
	wire [6:0] out7;
	wire [7:0] en_out;

	TopWithDisplay DisplayTop(Clk, Rst, out7, en_out);

	initial begin
		Rst <= 0;
		Clk <= 1'bz;
		#10;
		Clk <= 1'b0;
		forever #10 Clk <= ~Clk;
	end
endmodule

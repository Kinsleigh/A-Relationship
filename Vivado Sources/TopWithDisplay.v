`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2017 11:05:57 AM
// Design Name: 
// Module Name: TopWithDisplay
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


module TopWithDisplay(Clk, Rst, out7, en_out);
	input Clk, Rst;
	output [6:0] out7;
	output [7:0] en_out;
	
	wire [31:0] IF_PC_Out, WriteData, v0_out, v1_out, s4_out;
	
	TopMod Datapath(Clk, Rst, IF_PC_Out, WriteData, v0_out, v1_out, s4_out);
	
	Two4DigitDisplay XYDisp(Clk, v0_out[7:0], v1_out[7:0], s4_out[7:0], out7, en_out);
    
endmodule

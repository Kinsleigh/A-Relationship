`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2017 05:40:37 PM
// Design Name: 
// Module Name: Or
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


module Or(
	input A, B, 
	output reg Output);

    initial begin
      Output <= 0;
    end
	
    always @(A, B) begin
        Output <= A || B;
    end


endmodule

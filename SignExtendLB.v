`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2017 12:09:46 AM
// Design Name: 
// Module Name: SignExtendLHSH
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


module SignExtendLB(
    input [7:0] lbSignal, 
   output reg [31:0] outputSignal);
    
    initial begin
		outputSignal <=0;
    end
	
    always @(*)begin
		outputSignal  <= {{24{lbSignal[7]}}, lbSignal};
    end

endmodule

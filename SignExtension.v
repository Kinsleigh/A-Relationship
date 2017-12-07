`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - SignExtension.v
// Description - Sign extension module.
////////////////////////////////////////////////////////////////////////////////
module SignExtension(
	input [15:0]in, 
	output reg [31:0] out, out2);
    
    initial begin
        out <= 0;
        out2 <= 0;
    end
    
    always@(*)begin
        out <= {{16{in[15]}}, in};
        out2 <= {16'b0, in};
		
	end
		
endmodule

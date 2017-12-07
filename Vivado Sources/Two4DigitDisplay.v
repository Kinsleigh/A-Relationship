`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// The University of Arizona
// Electrical and Computer Engineering 
// Engineer: Ehsan Esmaili
// 
// Create Date: 09/22/2016
// Module Name: Two4DigitDisplay
// Description: 
//////////////////////////////////////////////////////////////////////////////////

module Two4DigitDisplay(Clk, SADRow, SADColumn, MinSAD, out7, en_out);

		parameter NUM_WIDTH = 8;

		input  Clk;
		input  [NUM_WIDTH - 1:0] SADRow, SADColumn, MinSAD;
		output [6:0] out7; //seg a, b, ... g
		output reg [7:0] en_out;
						 
		reg  [3:0] in4;        
		reg  [3:0] ColFirstDigit;
		reg  [3:0] ColSecondDigit;
		reg  [3:0] RowFirstDigit;
		reg  [3:0] RowSecondDigit;
		reg  [3:0] firstdigitB;
		reg  [3:0] seconddigitB;
		reg  [3:0] thirddigitB;
		reg  [3:0] forthdigitB;
		
		//--------- --------- --------- --------- //
		//-- to use the module SevenSegment 
		SevenSegment m1(in4, out7);
		//--------- --------- --------- --------- //
				
		//-- divider counter for ~1.5 Hz refresh rate (with 100MHz main clock)
		//reg  [25:0] cnt;
		// 95.3 Hz (with 100MHz main)
		reg [19:0] cnt;
		
		initial begin
			cnt <= 0;
			en_out <= 0;
		end
		
		always @(posedge Clk) begin
			cnt <= cnt + 1;
		end
		
		//-- to seperate each decimal digit for display
		always @(SADColumn) begin
			if (SADColumn < 10000)
				begin
					ColFirstDigit <= SADColumn%10;
					ColSecondDigit <= (SADColumn/10)%10;
				end 
			 else
			 begin
				ColFirstDigit <= 4'b1111;
				ColSecondDigit <= 4'b1111;
			 end
		end

		always @(SADRow) begin
			if (SADRow < 10000)
				begin
					RowFirstDigit <= SADRow%10;
					RowSecondDigit <= (SADRow/10)%10;
				end 
			 else
			 begin
				RowFirstDigit <= 4'b1111;
				RowSecondDigit <= 4'b1111;
			 end
		end
		
		always @(MinSAD) begin
			if (MinSAD < 10000)
				begin
					firstdigitB <= MinSAD%10;
					seconddigitB <= (MinSAD/10)%10;
					thirddigitB <= (MinSAD/100)%10;
					forthdigitB <= MinSAD/1000;
				end 
			 else
			 begin
				firstdigitB <= 4'b1111;
				seconddigitB <= 4'b1111;
				thirddigitB <= 4'b1111;
				forthdigitB <= 4'b1111;
			 end
		end
		
		//-- to display the number in the appropriate 7-segment digit
		always @(cnt) begin
			case(cnt[19:17])  //100MHz/(2^20) = 95.3 Hz
				3'b000: begin en_out <= 8'b11111110; in4 <= ColFirstDigit; end
				3'b001: begin en_out <= 8'b11111101; in4 <= ColSecondDigit; end
				3'b010: begin en_out <= 8'b11111011; in4 <= RowFirstDigit; end
				3'b011: begin en_out <= 8'b11110111; in4 <= RowSecondDigit; end
				3'b100: begin en_out <= 8'b11101111; in4 <= firstdigitB; end
				3'b101: begin en_out <= 8'b11011111; in4 <= seconddigitB; end
				3'b110: begin en_out <= 8'b10111111; in4 <= thirddigitB; end
				3'b111: begin en_out <= 8'b01111111; in4 <= forthdigitB; end
				default: begin en_out <= 8'b11111111; in4 <= 4'b1111; end 
			endcase
		 end
		
endmodule

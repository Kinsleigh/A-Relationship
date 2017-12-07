`timescale 1ns / 1ps


module Bus(RegWrite, MemWrite, BusData);
	input RegWrite , MemWrite;
	
	output reg [1:0] BusData;
	
	initial begin
		BusData[0] <= 0;
		BusData[1] <= 0;
	
	end
	
    always @(*) begin
        BusData[0] <= RegWrite;
        BusData[1] <= MemWrite;
    end

endmodule
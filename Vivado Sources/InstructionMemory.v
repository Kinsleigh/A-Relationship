`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/11/2017 02:32:22 PM
// Design Name: 
// Module Name: InstructionMemory
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


module InstructionMemory(Address, Instruction);
    input [31:0] Address; //Figure out size of address
    output reg [31:0] Instruction;
    
    reg [31:0] memory [0:395];
    integer i;
    initial begin
		Instruction <= 0;
		$readmemh("Instruction_memory.txt", memory);
    end
    
    always @(*) begin
		Instruction <= memory[Address[11:2]]; 
    end
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/17/2017 10:26:58 PM
// Design Name: 
// Module Name: topmod_tb
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


module topmod_tb();
    reg Clk, Reset;
    wire [31:0] PC_Out, WriteData, v0, v1, s4;
    //1) 32 bit program counter.
    //2) 32 bit write_data to register file.
    //3) 32 bit output of HI register.
    //4) 32 output of Lo register.
    TopMod aa(Clk, Reset, PC_Out, WriteData, v0, v1, s4);
    
    initial begin
        Reset <= 0;
        Clk <= 1'bz;
        #10;
        Clk <= 1'b0;
        forever #10 Clk <= ~Clk;
    end

endmodule

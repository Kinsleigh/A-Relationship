`timescale 1ns / 1ps
/*
// Names: Kinsleigh Wong, Zahra Sadeq
// Percent Effort : 50 - 50
This module implements the MEM/WB register  file. 

*/

module MEM_WB(Clk, DM_RD, ALUResult_Out, WR_Out, DM_ReadData, ALUResult, WriteReg, RW_Out, MtR_Out,C_RegWrite, C_MemtoReg, C_MemRead, WB_MemRead);
    input Clk;
    input [31:0] DM_RD;
    input [31:0] ALUResult_Out;
	input [4:0] WR_Out;
	input RW_Out, MtR_Out, C_MemRead;
        
    output [31:0] DM_ReadData;
    output [31:0] ALUResult;
	output [4:0] WriteReg;
	output C_RegWrite, C_MemtoReg, WB_MemRead;
	
    reg [31:0] Regis [0:1];
    reg [4:0] Regis_WR;
	reg Regis_Control [0:2];
	
	initial begin 
	    Regis[0] <= 0;
        Regis[1] <= 0;
        Regis_Control[2] <= 0;
        Regis_WR <= 0;
        Regis_Control[0] <= 0;
        Regis_Control[1] <= 0;
	end
	
	always @(posedge Clk) begin
		Regis[0] <= DM_RD;
		Regis[1] <= ALUResult_Out;
        Regis_Control[2] <= C_MemRead;
		Regis_WR <= WR_Out;
		Regis_Control[0] <= RW_Out;
		Regis_Control[1] <= MtR_Out;
	end
      
    assign DM_ReadData = Regis[0];
	assign ALUResult = Regis[1];
	assign WB_MemRead = Regis_Control[2];
	assign WriteReg = Regis_WR;
	assign C_RegWrite = Regis_Control[0];
	assign C_MemtoReg = Regis_Control[1];

endmodule

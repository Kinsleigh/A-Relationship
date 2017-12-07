`timescale 1ns / 1ps
/*
// Names: Kinsleigh Wong, Zahra Sadeq
// Percent Effort : 50 - 50
This module implements the EX/MEM register  file. 

*/

module EX_MEM(Clk, ReadData2, AluResult_In, WR_In, ReadData2_Out, ALUResult_Out, WR_Out,/**/ MW_Out, MR_Out, RW_, MtR_In, C_MemRead, C_MemWrite, RW_Out, MtR_Out, LS_Cont, LS_Control, LS_SECont, LS_SEControl, EX_MemWrite_S, C_MemWrite_S);
    input Clk;
    input [31:0] ReadData2;
    input [31:0] AluResult_In;
	input [4:0] WR_In;
	input [1:0] EX_MemWrite_S;
	input MW_Out, MR_Out, RW_, MtR_In, LS_Cont, LS_SECont;
    
    output [31:0] ReadData2_Out;
    output [31:0] ALUResult_Out;
	output [4:0] WR_Out;
	
	output C_MemRead, C_MemWrite, RW_Out, MtR_Out, LS_Control, LS_SEControl;
	
	output [1:0] C_MemWrite_S;

    reg [31:0] Regis [0:1];
	 reg [4:0] Reg_WR;
	reg Regis_Control [0:5];
	reg [1:0] RegMem_S;
	
	initial begin
	    Regis[0] <= 0;
        Regis[1] <= 0;
        Reg_WR <= 0;
        Regis_Control[0] <= 0;
        Regis_Control[1] <= 0;
        Regis_Control[2] <= 0;
        Regis_Control[3] <= 0;
        Regis_Control[4] <= 0;
		Regis_Control[5] <= 0;
		RegMem_S <= 0;

	end
	
	always @(posedge Clk) begin
		Regis[0] <= ReadData2;
		Regis[1] <= AluResult_In;
		Reg_WR <= WR_In;
		Regis_Control[0] <= MW_Out;
		Regis_Control[1] <= MR_Out;
		Regis_Control[2] <= RW_;
		Regis_Control[3] <= MtR_In;
		Regis_Control[4] <= LS_Cont;
		Regis_Control[5] <= LS_SECont;
		RegMem_S <= EX_MemWrite_S;

	end
    
    assign ReadData2_Out = Regis[0];
	assign ALUResult_Out = Regis[1];
	assign WR_Out = Reg_WR;
	assign C_MemWrite = Regis_Control[0];
	assign C_MemRead = Regis_Control[1];
	assign RW_Out = Regis_Control[2];
	assign MtR_Out = Regis_Control[3];
	assign LS_Control = Regis_Control[4];
	assign LS_SEControl = Regis_Control[5];
	assign C_MemWrite_S = RegMem_S;

endmodule

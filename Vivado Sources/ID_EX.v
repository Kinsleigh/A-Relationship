`timescale 1ns / 1ps
/*
// Names: Kinsleigh Wong, Zahra Sadeq
// Percent Effort : 50 - 50
This module implements the ID/EX register  file. 

*/

module ID_EX(Clk, NextInstruction, RD1, RD2, SE_In, Instruc1, Instruc2, NI_Ex, ReadData1, ReadData2, SE, WR_1, WR_2, AO, AS, RD, MW, MR, PCS_In, RW, MtR, C_AluOp, C_RegDst, C_AluSrc, MW_Out, MR_Out, PCS_Out, RW_In, MtR_In, Comp_ControlIn, Comp_Control, j_Cont, j_Control, JumpE_D, JumpE, jORjal_D, jORjal, jal_Cont, jal_Control, D_RegRs, EX_RegRs, IDEXWrite, FlushEnable);
	input Clk;
    input [31:0] NextInstruction;
	input [31:0] RD1, RD2;
    input [31:0] SE_In, JumpE_D;
	input [4:0] Instruc1, Instruc2, D_RegRs;	
	input [1:0] AO;
	input AS, RD, MW, MR, PCS_In, RW, MtR, Comp_ControlIn, j_Cont, jORjal_D, jal_Cont, IDEXWrite, FlushEnable;

    output [31:0] NI_Ex;
	output [31:0] ReadData1, ReadData2;
	output [31:0] SE, JumpE;
	output [4:0] WR_1, WR_2, EX_RegRs;
	
	output [1:0] C_AluOp;
	output C_AluSrc, C_RegDst, MW_Out, MR_Out, PCS_Out, RW_In, MtR_In, Comp_Control, j_Control, jORjal, jal_Control;
	
    reg [31:0] Regis [0:4];
    reg [4:0] Regis_5bit [0:2]; 
	reg [1:0] Regis_AluOp;
	(* keep = "true" *) reg Regis_Control [0:10]; 
	reg Regis_21;
	
   initial begin
    Regis[0] <= 0;
    Regis[1] <= 0;
    Regis[2] <= 0;
    Regis[3] <= 0;
    Regis[4] <= 0;
    Regis_Control[0] <= 0;
    Regis_Control[1] <= 0;
    Regis_Control[2] <= 0;
    Regis_Control[3] <= 0;
    Regis_Control[4] <= 0;
    Regis_Control[5] <= 0;
    Regis_Control[6] <= 0;
	Regis_Control[7] <= 0;
	Regis_Control[8] <= 0;
	Regis_Control[9] <= 0;
	Regis_Control[10] <= 0;
    Regis_5bit[0] <= 0;
    Regis_5bit[1] <= 0;
    Regis_5bit[2] <= 0;
    Regis_AluOp <= 0;
   end
	  
     always @(posedge Clk) begin
	     if ((IDEXWrite == 0)  && (FlushEnable == 0)) begin
			Regis[0] <= NextInstruction;
			Regis[1] <= RD1;
			Regis[2] <= RD2;
			Regis[3] <= SE_In;
			Regis[4] <= JumpE_D; 
			Regis_5bit[0] <= Instruc1;
			Regis_5bit[1] <= Instruc2;
	    	Regis_5bit[2] <= D_RegRs;
			Regis_AluOp <= AO;
			Regis_Control[0] <= AS;
			Regis_Control[1] <= RD;
			Regis_Control[2] <= MW;
			Regis_Control[3] <= MR;
			Regis_Control[4] <= PCS_In;
			Regis_Control[5] <= RW;
			Regis_Control[6] <= MtR;
			Regis_Control[7] <= Comp_ControlIn;
			Regis_Control[8] <= j_Cont; 
			Regis_Control[9] <= jORjal_D; 
			Regis_Control[10] <= jal_Cont;
		end
		else if(IDEXWrite) begin
			Regis[0] <= Regis[0];
			Regis[1] <= Regis[1];
			Regis[2] <= Regis[2];
			Regis[3] <= Regis[3];
			Regis[4] <= Regis[4];
			Regis_5bit[0] <= Regis_5bit[0];
			Regis_5bit[1] <= Regis_5bit[1];
	    	Regis_5bit[2] <= Regis_5bit[2];
			Regis_AluOp <= Regis_AluOp;
			Regis_Control[0] <= Regis_Control[0];
			Regis_Control[1] <= Regis_Control[1];
			Regis_Control[2] <= Regis_Control[2];
			Regis_Control[3] <= Regis_Control[3];
			Regis_Control[4] <= Regis_Control[4];
			Regis_Control[5] <= Regis_Control[5];
			Regis_Control[6] <= Regis_Control[6];
			Regis_Control[7] <= Regis_Control[7];
			Regis_Control[8] <= Regis_Control[8];
			Regis_Control[9] <= Regis_Control[9];
			Regis_Control[10] <= Regis_Control[10]; 
		end
		else if(FlushEnable) begin
			Regis[0] <= 0;
			Regis[1] <= 0;
			Regis[2] <= 0;
			Regis[3] <= 0;
			Regis[4] <= 0;
			Regis_Control[0] <= 0;
			Regis_Control[1] <= 0;
			Regis_Control[2] <= 0;
			Regis_Control[3] <= 0;
			Regis_Control[4] <= 0;
			Regis_Control[5] <= 0;
			Regis_Control[6] <= 0;
			Regis_Control[7] <= 0;
			Regis_Control[8] <= 0;
			Regis_Control[9] <= 0;
			Regis_Control[10] <= 0;
			Regis_5bit[0] <= 0;
			Regis_5bit[1] <= 0;
			Regis_5bit[2] <= 0;
			Regis_AluOp <= 0;
		end
     end 
      
	assign NI_Ex = Regis[0];
	assign  ReadData1 = Regis[1];
	assign  ReadData2 = Regis[2];
	assign  SE = Regis[3];
	assign JumpE = Regis[4];
	assign  WR_1 = Regis_5bit[0];
	assign  WR_2 = Regis_5bit[1];
	assign  EX_RegRs = Regis_5bit[2];
	assign  C_AluOp = Regis_AluOp;
	assign  C_AluSrc = Regis_Control[0];
	assign  C_RegDst = Regis_Control[1];
	assign  MW_Out = Regis_Control[2];
	assign  MR_Out = Regis_Control[3];
	assign  PCS_Out = Regis_Control[4];
	assign  RW_In = Regis_Control[5];
	assign  MtR_In = Regis_Control[6];
	assign Comp_Control = Regis_Control[7];
	assign j_Control = Regis_Control[8];
	assign jORjal = Regis_Control[9];
	assign jal_Control = Regis_Control[10];
	

endmodule

`timescale 1ns / 1ps
/*
// Names: Kinsleigh Wong, Zahra Sadeq
// Percent Effort : 50 - 50
This module implements the ID/EX register  file. 

*/

module ID_EX(Clk, NextInstruction, RD1, RD2, SE_In, Se_sa_In, Instruc1, Instruc2, I21, NI_Ex, ReadData1, ReadData2, SE, SE_sa, WR_1, WR_2, I21_Out, AO, AS, RD, MW, MR, PCS_In, RW, MtR, C_AluOp, C_RegDst, C_AluSrc, MW_Out, MR_Out, PCS_Out, RW_In, MtR_In, Comp_ControlIn, Comp_Control, LS_C, LS_Cont, LS_SEC, LS_SECont, D_MemWrite_S, EX_MemWrite_S, j_Cont, j_Control, JumpE_D, JumpE, jORjal_D, jORjal, jal_Cont, jal_Control, D_RegRs, EX_RegRs, IDEXWrite, FlushEnable);
	input Clk;
    input [31:0] NextInstruction;
	input [31:0] RD1, RD2;
    input [31:0] SE_In, Se_sa_In, JumpE_D;
	input [4:0] Instruc1, Instruc2, D_RegRs;	
	input I21;	
	input [3:0] AO;
	input AS, RD, MW, MR, PCS_In, RW, MtR, Comp_ControlIn, LS_C, LS_SEC, j_Cont, jORjal_D, jal_Cont, IDEXWrite, FlushEnable;
	input [1:0] D_MemWrite_S;
	output [1:0] EX_MemWrite_S;

    output [31:0] NI_Ex;
	output [31:0] ReadData1, ReadData2;
	output [31:0] SE, SE_sa, JumpE;
	output [4:0] WR_1, WR_2, EX_RegRs;
	output I21_Out;
	
	output [3:0] C_AluOp;
	output C_AluSrc, C_RegDst, MW_Out, MR_Out, PCS_Out, RW_In, MtR_In, Comp_Control, LS_Cont, LS_SECont, j_Control, jORjal, jal_Control;
	
	reg [1:0] RegMem_S;
    reg [31:0] Regis [0:5];
    reg [4:0] Regis_5bit [0:2]; 
	reg [3:0] Regis_AluOp;
	(* keep = "true" *) reg Regis_Control [0:12]; 
	reg Regis_21;
	
   initial begin
    Regis[0] <= 0;
    Regis[1] <= 0;
    Regis[2] <= 0;
    Regis[3] <= 0;
    Regis[4] <= 0;
    Regis[5] <= 0;
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
	Regis_Control[11] <= 0;
	Regis_Control[12] <= 0;
	RegMem_S <= 0;
    Regis_5bit[0] <= 0;
    Regis_5bit[1] <= 0;
    Regis_5bit[2] <= 0;
    Regis_AluOp <= 0;
    Regis_21 <= 0;
   end
	  
     always @(posedge Clk) begin
	     if ((IDEXWrite == 0)  && (FlushEnable == 0)) begin
			Regis[0] <= NextInstruction;
			Regis[1] <= RD1;
			Regis[2] <= RD2;
			Regis[3] <= SE_In;
			Regis[4] <= Se_sa_In;
			Regis[5] <= JumpE_D; 
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
			Regis_Control[8] <= LS_C;
			Regis_Control[9] <= LS_SEC;
			Regis_Control[10] <= j_Cont; 
			Regis_Control[11] <= jORjal_D; 
			Regis_Control[12] <= jal_Cont;
			RegMem_S <= D_MemWrite_S;
			Regis_21 <= I21;
		end
		else if(IDEXWrite) begin
			Regis[0] <= Regis[0];
			Regis[1] <= Regis[1];
			Regis[2] <= Regis[2];
			Regis[3] <= Regis[3];
			Regis[4] <= Regis[4];
			Regis[5] <= Regis[5]; 
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
			Regis_Control[11] <= Regis_Control[11]; 
			Regis_Control[12] <= Regis_Control[12];
			RegMem_S <= RegMem_S;
			Regis_21 <= Regis_21;
		end
		else if(FlushEnable) begin
			Regis[0] <= 0;
			Regis[1] <= 0;
			Regis[2] <= 0;
			Regis[3] <= 0;
			Regis[4] <= 0;
			Regis[5] <= 0;
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
			Regis_Control[11] <= 0;
			Regis_Control[12] <= 0;
			RegMem_S <= 0;
			Regis_5bit[0] <= 0;
			Regis_5bit[1] <= 0;
			Regis_5bit[2] <= 0;
			Regis_AluOp <= 0;
			Regis_21 <= 0;
		end
     end 
      
	assign NI_Ex = Regis[0];
	assign  ReadData1 = Regis[1];
	assign  ReadData2 = Regis[2];
	assign  SE = Regis[3];
	assign  SE_sa = Regis[4];
	assign JumpE = Regis[5];
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
	assign LS_Cont = Regis_Control[8];
	assign LS_SECont = Regis_Control[9];
	assign j_Control = Regis_Control[10];
	assign jORjal = Regis_Control[11];
	assign jal_Control = Regis_Control[12];
	assign I21_Out = Regis_21;
	assign EX_MemWrite_S = RegMem_S;
	

endmodule

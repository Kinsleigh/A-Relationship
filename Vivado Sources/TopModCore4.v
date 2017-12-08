`timescale 1ns / 1ps
/*
Names: Kinsleigh Wong, Kobe Bryant
Percent Effort : 50 - 50

This is a 5 stage pipeline.
All branches and jumps are done in the execute stage. 

Module: TopMod
*/

module TopModCore4(
	input Clk, Reset,
	output wire [31:0] IF_PC_Out, WriteData,
	output wire [31:0] v0, v1, s4);
	
	//Wires///////////////////////////////////////
	wire UnsignedSignal;
	//Wires for IF/////// 	///////////////
	wire [31:0] IM_Out, PC_In, PC_In1, PC_In0, JumpE;
	////////////////////////////////////
	
	//Wires for ID//////////////////////
	wire [31:0] RD1, RD2,  SE_1, SE_2, SE_In,  WriteData_F;
	wire [4:0] WriteReg, WriteReg_F;
	wire jORjal, jal_Control, j_Control, PCControl;
		//Control Wires/////////////////
		//ID
		wire [1:0] AO;
		wire AS, RD, MW, MR, PCS_In, RW, MtR, SEControl, Comp_ControlIn;
		//EX
		wire [1:0] C_AluOp;
		wire C_RegDst, C_AluSrc, Comp_Control;
		wire MW_Out, MR_Out, PCS_Out, RW_In, MtR_In;
		//MEM
		wire PCS, C_MemRead, C_MemWrite;
		wire RW_Out, MtR_Out;
		//WB
		wire C_RegWrite, C_MemtoReg, WB_MemRead;
		////////////////////////////////
	////////////////////////////////////
	
	wire [31:0] NI_Ex, SE, ReadData1, JumpE_D, ReadData2;
	wire [4:0] WR_1, WR_2, EX_RegRs;
	wire I_21;
	wire jal_Cont, jORjal_D, j_Cont;
	
	//Wires for EX//////////////////////
	wire [31:0] SE_left, Data1, Data2, AddRes_In, ALUResult_In, ALUResult_In_Ex, ReadData1A, ReadData2B, ReadData1B;
	wire [4:0] WR_In_E, WR_In;
	wire [2:0] AluSignal;
	wire SAControl, WriteEnable, ZeroIn, ZeroIn1, ZeroNot, ALU_jr;
	////////////////////////////////////
	
	wire ZeroOut;
	wire [4:0] WR_Out;
	wire [31:0] ALUResult_Out, ReadData2_Out;
	
	//wire [31:0] AddRes_Out; already declared
	
	//Wires for MEM/////////////////////
	wire [31:0] DM_RD, DM_ReadData_1, ReadData2_OutA;
	////////////////////////////////////
	
	wire [31:0] DM_ReadData, ALUResult;
	    
    wire [1:0] E_MuxAlu_1, E_MuxAlu_2, /*E_MuxWriteData2,*/ E_jrMux;
    wire E_MuxWriteData;

    wire [1:0] D_MemWrite_S, EX_MemWrite_S, C_MemWrite_S;
	//Wires for WB//////////////////////
	
	////////////////////////////////////
	
	//wires for Hazard Detection Unit////////////
       wire MuxEn, PCEn, IFIDEn;
       wire [1:0] BusData, BusData_out;
       wire HazardControl;
       wire IDEXWrite, EXMEMWrite;
       wire FlushEnable;


	//End Wires///////////////////////////////////
	
	//Begin Program///////////////////////////////
	
	//IF////////////////////////////////

	wire [31:0] IF_Instruction, IF_NextAddress;
	wire [31:0] ID_Instruction, ID_NextAddress;

	InstructionMemory IF_IM(IF_PC_Out, IF_Instruction);
	Adder IF_NextAddressAdd(IF_PC_Out, 32'd4, IF_NextAddress);

	ProgramCounter IF_PC(Clk, Reset, PC_In, IF_PC_Out, PCEn);
	
	Mux32 IF_muxb(IF_NextAddress, AddRes_In, PCS, PC_In0); //The mux going into the 0 position of the mux right before PC 
	
	Mux32_2 IF_muxaa(ReadData1, ALUResult_Out, ALUResult, E_jrMux, ReadData1B); //I don't think I need this, I can probably go without it. 
	Mux32 IF_muxa(ReadData1B, JumpE, jORjal, PC_In1); //The mux going into the 1 position of the mux right before PC
	Or IF_or(j_Control, ALU_jr, PCControl); //The control signal for the mux before PC. AKA decides if we are doing j/jr/jal or branch/next instruction. 
	Mux32 IF_muxc(PC_In0, PC_In1, PCControl, PC_In); //The mux right before PC.
	////////////////////////////////////
	
	IF_ID ifid(Clk, IF_Instruction, IF_NextAddress, ID_Instruction, ID_NextAddress, IFIDEn, FlushEnable);
	
	//ID////////////////////////////////
	 HazardDetection Hazard( MR_Out, RW_In ,ID_Instruction[5:0], ID_Instruction[31:26], WR_2 ,ID_Instruction[20:16], ID_Instruction[25:21],WR_1 , MuxEn, PCEn, IFIDEn, IDEXWrite, EXMEMWrite, PCS, FlushEnable, jORjal, ALU_jr, jORjal_D);
	 Bus BusHazard(RW, MW, BusData);
    Mux2 HazardMux(BusData, MuxEn, BusData_out); 

	Controller Cont(ID_Instruction[31:26], ID_Instruction[16], RW, AS, RD, MW, MR, MtR, PCS_In, AO, SEControl, Comp_ControlIn, jal_Cont, j_Cont, jORjal_D);
	
	JumpExtend IF_je(IF_NextAddress[31:28], ID_Instruction[25:0], JumpE_D);
	
	RegisterFile ID_RF(Clk, Reset, ID_Instruction[25:21], ID_Instruction[20:16], WriteReg, WriteData, C_RegWrite, RD1, RD2, v0, v1, s4);
	SignExtension ID_SE(ID_Instruction[15:0], SE_1);
	ZeroExtension ID_ZE(ID_Instruction[15:0], SE_2);
	Mux32 id_mux(SE_2, SE_1, SEControl, SE_In);
	////////////////////////////////////
		
	//From A0 onwards it's all Control signals. 
	ID_EX idex(Clk, ID_NextAddress, RD1, RD2, SE_In, ID_Instruction[20:16], ID_Instruction[15:11], NI_Ex, ReadData1, ReadData2, SE, WR_1, WR_2, AO, AS, RD, BusData_out[1], MR, PCS_In, BusData_out[0], MtR, C_AluOp, C_RegDst, C_AluSrc, MW_Out, MR_Out, PCS_Out, RW_In, MtR_In, Comp_ControlIn, Comp_Control, j_Cont, j_Control, JumpE_D, JumpE, jORjal_D, jORjal, jal_Cont, jal_Control, ID_Instruction[25:21], EX_RegRs, IDEXWrite, FlushEnable);
	
	//EX////////////////////////////////

	Forward forw(EX_RegRs, WR_1, WR_In, WR_Out, WriteReg, MW_Out, ALU_jr, RW_Out, C_MemRead, C_MemWrite, C_RegWrite, WB_MemRead, E_MuxAlu_1, E_MuxAlu_2, E_jrMux, E_MuxWriteData);

	Mux32_2 EX_muxaa(ReadData1, ALUResult_Out, WriteData, E_MuxAlu_1, ReadData1A);
	Mux32_2 EX_muxbb(ReadData2, ALUResult_Out, WriteData, E_MuxAlu_2, ReadData2B);
	Mux32 EX_muxa(ReadData1A, SE, SAControl, Data1); 
	Mux32 EX_muxb(ReadData2B, SE, C_AluSrc, Data2);
	
	ALUControl EX_AluCtrl(C_AluOp, SE[5:0], SAControl,  ALU_jr, AluSignal);
	ALU32Bit EX_Alu(AluSignal, Data1, Data2, ALUResult_In_Ex, ZeroIn1);
	
	Not EX_muxNOT(ZeroIn1, ZeroNot);
	Mux1 EX_mux(ZeroIn1, ZeroNot, Comp_Control, ZeroIn);
	
	ShiftLeft2 EX_sl2(SE, SE_left);
	Adder EX_add(NI_Ex, SE_left, AddRes_In);
	
	Mux32 EX_mux32(ALUResult_In_Ex, NI_Ex, jal_Control, ALUResult_In);
	Mux5 EX_mux5(WR_1, WR_2, C_RegDst, WR_In_E);
	Mux5Spec EX_mux5spec(WR_In_E, jal_Control, WR_In);
	
	And MEM_and(PCS_Out, ZeroIn, PCS);
	
	////////////////////////////////////
	//MW_Out and onwards is for Control signals. 
	EX_MEM exmem(Clk, ReadData2B, ALUResult_In, WR_In, ReadData2_OutA, ALUResult_Out, WR_Out,/**/ MW_Out, MR_Out, RW_In, MtR_In, C_MemRead, C_MemWrite, RW_Out, MtR_Out);
	
	//MEM///////////////////////////////
	Mux32 MEM_mux(ReadData2_OutA, WriteData, E_MuxWriteData, ReadData2_Out);

	DataMemoryCore4 MEM_dm(Clk, ALUResult_Out, ReadData2_Out, C_MemWrite, C_MemRead, DM_RD);
	////////////////////////////////////
	MEM_WB memwb(Clk, DM_RD, ALUResult_Out, WR_Out, DM_ReadData, ALUResult, WriteReg, RW_Out, MtR_Out, C_RegWrite, C_MemtoReg, C_MemRead, WB_MemRead);
	
	//WB////////////////////////////////
	Mux32 WB_mux(DM_ReadData, ALUResult, C_MemtoReg, WriteData);
	////////////////////////////////////
	
	//End Program/////////////////////////////////
	
endmodule


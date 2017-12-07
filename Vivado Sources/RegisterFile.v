`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
//
//
// Student(s) Name and Last Name: FILL IN YOUR INFO HERE!
//
//
// Module - register_file.v
// Description - Implements a register file with 32 32-Bit wide registers.
//
// 
// INPUTS:-
// ReadRegister1: 5-Bit address to select a register to be read through 32-Bit 
//                output port 'ReadRegister1'.
// ReadRegister2: 5-Bit address to select a register to be read through 32-Bit 
//                output port 'ReadRegister2'.
// WriteRegister: 5-Bit address to select a register to be written through 32-Bit
//                input port 'WriteRegister'.
// WriteData: 32-Bit write input port.
// RegWrite: 1-Bit control input signal.
//
// OUTPUTS:-
// ReadData1: 32-Bit registered output. 
// ReadData2: 32-Bit registered output. 
//
// FUNCTIONALITY:-
// 'ReadRegister1' and 'ReadRegister2' are two 5-bit addresses to read two 
// registers simultaneously. The two 32-bit data sets are available on ports 
// 'ReadData1' and 'ReadData2', respectively. 'ReadData1' and 'ReadData2' are 
// registered outputs (output of register file is written into these registers 
// at the falling edge of the clock). You can view it as if outputs of registers
// specified by ReadRegister1 and ReadRegister2 are written into output 
// registers ReadData1 and ReadData2 at the falling edge of the clock. 
//
// 'RegWrite' signal is high during the rising edge of the clock if the input 
// data is to be written into the register file. The contents of the register 
// specified by address 'WriteRegister' in the register file are modified at the 
// rising edge of the clock if 'RegWrite' signal is high. The D-flip flops in 
// the register file are positive-edge (rising-edge) triggered. (You have to use 
// this information to generate the write-clock properly.) 
//
// NOTE:-
// We will design the register file such that the contents of registers do not 
// change for a pre-specified time before the falling edge of the clock arrives 
// to allow for data multiplexing and setup time.
////////////////////////////////////////////////////////////////////////////////

module RegisterFile(
	input Clk, Rst,
	input [4:0] ReadRegister1, ReadRegister2, WriteRegister, 
	input [31:0] WriteData, 
	input RegWrite, 
	output [31:0] ReadData1, ReadData2, 
	output [31:0] v0, v1, s4);

	integer i;

	(*keep = "TRUE"*) reg [31:0] Regis [0:31];
	
	initial begin
		for(i = 0; i < 32; i = i + 1) begin
			Regis[i] <= 0;
		end
		Regis[29] <= 4092;
	end
	  
	always @(negedge Clk) begin
		if(RegWrite && WriteRegister != 0 && Rst == 0) begin
			Regis[WriteRegister] <= WriteData;
		end else if(Rst == 1) begin
			Regis[0] <= 0;
			Regis[1] <= 0;
			Regis[2] <= 0;
			Regis[3] <= 0;
			Regis[4] <= 0;
			Regis[5] <= 0;
			Regis[6] <= 0;
			Regis[7] <= 0;
			Regis[8] <= 0;
			Regis[9] <= 0;
			Regis[10] <= 0;
			Regis[11] <= 0;
			Regis[12] <= 0;
			Regis[13] <= 0;
			Regis[14] <= 0;
			Regis[15] <= 0;
			Regis[16] <= 0;
			Regis[17] <= 0;
			Regis[18] <= 0;
			Regis[19] <= 0;
			Regis[20] <= 0;
			Regis[21] <= 0;
			Regis[22] <= 0;
			Regis[23] <= 0;
			Regis[24] <= 0;
			Regis[25] <= 0;
			Regis[26] <= 0;
			Regis[27] <= 0;
			Regis[28] <= 0;
			Regis[29] <= 4092;
			Regis[30] <= 0;
			Regis[31] <= 0;
		end
	end
	
	assign ReadData1 = Regis[ReadRegister1];
	assign ReadData2 = Regis[ReadRegister2];
	assign v0 = Regis[2];
	assign v1 = Regis[3];
	assign s4 = Regis[20];

endmodule

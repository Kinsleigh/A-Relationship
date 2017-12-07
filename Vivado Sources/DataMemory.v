`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - data_memory.v
// Description - 32-Bit wide data memory.
//
// INPUTS:-
// Address: 32-Bit address input port.
// WriteData: 32-Bit input port.
// Clk: 1-Bit Input clock signal.
// MemWrite: 1-Bit control signal for memory write.
// MemRead: 1-Bit control signal for memory read.
//
// OUTPUTS:-
// ReadData: 32-Bit registered output port.
//
// FUNCTIONALITY:-
// Design the above memory similar to the 'RegisterFile' model in the previous 
// assignment.  Create a 1K memory, for which we need 10 bits.  In order to 
// implement byte addressing, we will use bits Address[11:2] to index the 
// memory location. The 'WriteData' value is written into the address 
// corresponding to Address[11:2] in the positive clock edge if 'MemWrite' 
// signal is 1. 'ReadData' is the value of memory location Address[11:2] if 
// 'MemRead' is 1, otherwise, it is 0x00000000. The reading of memory is not 
// clocked.
//
// you need to declare a 2d array. in this case we need an array of 1024 (1K)  
// 32-bit elements for the memory.   
// for example,  to declare an array of 256 32-bit elements, declaration is: reg[31:0] memory[0:255]
// if i continue with the same declaration, we need 8 bits to index to one of 256 elements. 
// however , address port for the data memory is 32 bits. from those 32 bits, least significant 2 
// bits help us index to one of the 4 bytes within a single word. therefore we only need bits [9-2] 
// of the "Address" input to index any of the 256 words. 
////////////////////////////////////////////////////////////////////////////////

module DataMemory(Clk, Address, WriteData, MemWrite, MemWrite_S, MemRead, ReadData); 

    input [31:0] Address; 	// Input Address 
    input [31:0] WriteData; // Data that needs to be written into the address 
    input Clk;
    input MemWrite; 		// Control signal for memory write 
    input [1:0] MemWrite_S;
    input MemRead; 			// Control signal for memory read 

    output reg [31:0] ReadData; // Contents of memory location at Address

    /* Please fill in the implementation here */
    integer i;
    reg [31:0] Memory [0:1023];
    
    initial begin
		//$readmemh("Instruction_memory_data.txt", Memory);
		Memory[0] = 32'h4;
		Memory[1] = 32'h4;
		Memory[2] = 32'h2;
		Memory[3] = 32'h2;
		Memory[4] = 32'h0;
		Memory[5] = 32'h0;
		Memory[6] = 32'h1;
		Memory[7] = 32'h2;
		Memory[8] = 32'h0;
		Memory[9] = 32'h0;
		Memory[10] = 32'h3;
		Memory[11] = 32'h4;
		Memory[12] = 32'h0;
		Memory[13] = 32'h0;
		Memory[14] = 32'h0;
		Memory[15] = 32'h0;
		Memory[16] = 32'h0;
		Memory[17] = 32'h0;
		Memory[18] = 32'h0;
		Memory[19] = 32'h0;
		Memory[20] = 32'h1;
		Memory[21] = 32'h2;
		Memory[22] = 32'h3;
		Memory[23] = 32'h4;
    end
    
    always @(posedge Clk) begin
        if (MemWrite) begin
            if(MemWrite_S == 0)
                Memory[Address[11:2]] <= WriteData;
    		else if (MemWrite_S == 1) begin
    			if (Address[1:0] == 0) //We must deal with the byte addressing. 
    				Memory[Address[11:2]][7:0] <= WriteData[7:0];
    			else if (Address[1:0] == 1)
    				Memory[Address[11:2]][15:8] <= WriteData[7:0];
    			else if (Address[1:0] == 2)
    				Memory[Address[11:2]][23:16] <= WriteData[7:0];
    			else //Otherwise it must be 3. 
    				Memory[Address[11:2]][31:17] <= WriteData[7:0];
    		end
    		else if(MemWrite_S == 2) begin
    			if(Address[1] == 0)
    				Memory[Address[11:2]][15:0] <= WriteData[15:0];
    			else
    				Memory[Address[11:2]][31:16] <= WriteData[15:0];
    		end
        end
    end
    
    always @(*) begin //this does not happen at the posedge Clk read the summary above
        if (MemRead)
            ReadData <= Memory[Address[11:2]];
        else
            ReadData <= 0;
    end

endmodule

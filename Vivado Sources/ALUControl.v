`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/16/2017 07:29:48 PM
// Design Name: 
// Module Name: ALUControl
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

//ALUOp table
//0000 -> Normal R-Types 
//0001 -> Mul opertation,(since i dont write back to register like all the others do)  
//0010 -> seh & seb 
//0011 -> andi
//0100 -> ori
//0101 -> xori
//0110 -> addi
//0111 -> addiu
//1000 -> slti
//1001 -> sltiu 
module ALUControl(ALUOp, SAControl, ALUSignal, ITwentyOne, ISix, IFiveToZero, Inine, UnsignedSignal, ALU_C);
//inputs
input ITwentyOne, Inine;//this and the one below is used for SA like say sra vs srav where, where sra is I[21] and srav I[6]
//list of operations that is one for the above variable: rotr =1, srl = 0
input ISix; // list of operations that is one for this variable: rotrv=1, srlv= 0
input [5:0]IFiveToZero; //Instruction [5:0]
//outputs
input [3:0]ALUOp;//this one determines which kind of instruction im going to be executing, table is above
output reg SAControl;//this goes to a mux to determine if im doing variable shifts or not, like sllv,srav, rotrv, etc 
output reg [4:0] ALUSignal; //now this signal here tells the ALU which kind of operation it should execute, such as add,and, or etc
output reg UnsignedSignal;

////////////////
output reg ALU_C;
/////////////////
initial begin
    ALUSignal <= 0;
    SAControl <= 0;
    UnsignedSignal <= 0;
    ALU_C <= 0;
end

always@(*)begin
    ////////////////
    ALU_C <= 0;
    ///////////////
    SAControl <=0;
    ALUSignal <= 0;
    UnsignedSignal <= 0;
    if(ALUOp == 4'b0000)begin //normal R-Types //asumming that instruction [31:26] is all zeros, 
    //take a look at instruction [5:0]
           if(IFiveToZero == 6'b000110) begin //srlv and rotrv
                if(ISix == 0)begin //srlv
                     ALUSignal <= 5'b01101;
                     //SAControl <=1;
                end
                else begin //rotrv
                     ALUSignal <= 5'b01110;
                    // SAControl <=1;
                end
            end
            else if(IFiveToZero == 6'b000010) begin //srl and rotr
                if(ITwentyOne == 0)begin //srl
                     ALUSignal <= 5'b01101;
                     SAControl <=1;
                end
                else begin //rotr
                     ALUSignal <= 5'b01110;
                     SAControl <=1;
                end
            end 
            else if(IFiveToZero == 6'b100001) begin //addu
                 ALUSignal <= 5'b00010;
            end
            else if(IFiveToZero == 6'b100000) begin //add
                 ALUSignal <= 5'b00010;
            end
            else if(IFiveToZero == 6'b100010) begin //sub
                 ALUSignal <= 5'b00110;
            end
            else if(IFiveToZero == 6'b100100) begin //and
                 ALUSignal <= 5'b00000;
            end
            else if(IFiveToZero == 6'b100101) begin //or
                 ALUSignal <= 5'b00001;
            end
            else if(IFiveToZero == 6'b100111) begin //nor
                 ALUSignal <= 5'b00100;
            end
            else if(IFiveToZero== 6'b100110) begin //xor
                 ALUSignal <= 5'b00101;
            end
            else if(IFiveToZero == 6'b000000) begin //sll
                SAControl <=1;
                 ALUSignal <= 5'b01000;
            end
            else if(IFiveToZero == 6'b000100) begin //sllv
                 //SAControl <=1;
                 ALUSignal <= 5'b01000;
            end
            else if(IFiveToZero == 6'b101010) begin //slt
                 ALUSignal <= 5'b00111;
            end
            else if(IFiveToZero == 6'b001011) begin //movn
                 ALUSignal <= 5'b01010;
            end
            else if(IFiveToZero == 6'b001010) begin //movz
                 ALUSignal <= 5'b01011;
            end
            else if(IFiveToZero == 6'b000011) begin //sra
                SAControl <= 1;
                 ALUSignal <= 5'b01111;
            end
            else if(IFiveToZero == 6'b000111) begin //srav
                 ALUSignal <= 5'b01111;
            end
            else if(IFiveToZero == 6'b101011) begin //sltu
                 //UnsignedSignal <= 1;
                 ALUSignal <= 5'b00111;
            end
            else if(IFiveToZero == 6'b001000)begin //jr
                 ALU_C <= 1;
            end     
    end //end of normal R-Types	
    else if (ALUOp == 4'b0010)begin //seh and seb
        if(Inine == 1)begin //seh
            ALUSignal <= 5'b10101;
        end
        else begin //seb
            ALUSignal <= 5'b10100;
        end
    end // the immediate types
    else if (ALUOp == 4'b0011)begin //andi
        ALUSignal <= 5'b00000;
    end
    else if (ALUOp == 4'b0100)begin //ori
        ALUSignal <= 5'b00001;
    end
    else if (ALUOp == 4'b0101)begin //xori
        ALUSignal <= 5'b00101;
    end
    else if (ALUOp == 4'b0110)begin //addi
        ALUSignal <= 5'b00010;
    end
    else if (ALUOp == 4'b0111)begin //addiu
        UnsignedSignal <= 1;
        ALUSignal <= 5'b00010; 
    end
    else if (ALUOp == 4'b1000)begin //slti
        ALUSignal <= 5'b00111;
    end //end of I-Types 
    else if (ALUOp == 4'b1001)begin //sltiu
        //UnsignedSignal <= 1;
        ALUSignal <= 5'b00111;
    end
    //////////////////////////////////// new ////////////////////////////
     else if(ALUOp == 4'b1011)begin // bgtz & blez
            ALUSignal <= 5'b10001;
       end
       else if(ALUOp == 4'b1100)begin // bltz or bgez
            ALUSignal <= 5'b11001;
       end
       else if(ALUOp == 4'b1010)begin //lui
            ALUSignal <= 5'b10011;
       end
       else if(ALUOp == 4'b1101) begin
        ALUSignal <= 5'b00110;
       end
    ////////////////////////////////////////////////////////////////////
	else
		ALUSignal <= 0;
    
end

endmodule

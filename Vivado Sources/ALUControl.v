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
module ALUControl(
    input [1:0] ALUOp, 
    input [5:0] IFiveToZero,
    output reg SAControl, ALU_C, 
    output reg [2:0] ALUSignal);

initial begin
    ALUSignal <= 0;
    SAControl <= 0;
    ALU_C <= 0;
end

always@(*)begin
    ////////////////
    ALU_C <= 0;
    ///////////////
    SAControl <=0;
    ALUSignal <= 0;
    if(ALUOp == 2'b00) begin //normal R-Types //asumming that instruction [31:26] is all zeros, 
    //take a look at instruction [5:0]
        if(IFiveToZero == 6'b100000) begin //add
            ALUSignal <= 3'b000;
        end
        else if(IFiveToZero == 6'b100010) begin //sub
            ALUSignal <= 3'b001;
        end
        else if(IFiveToZero== 6'b100110) begin //xor
            ALUSignal <= 3'b100;
        end
        else if(IFiveToZero == 6'b000000) begin //sll
            SAControl <= 1;
            ALUSignal <= 3'b101;
        end
        else if(IFiveToZero == 6'b101010) begin //slt
            ALUSignal <= 3'b011;
        end
        else if(IFiveToZero == 6'b000011) begin //sra
            SAControl <= 1;
            ALUSignal <= 3'b110;
        end
        else if(IFiveToZero == 6'b001000)begin //jr
            ALU_C <= 1;
        end     
    end //end of normal R-Types	

    else if (ALUOp == 2'b10) begin //addi, lw, sw
    ALUSignal <= 3'b000;
    end
    else if (ALUOp == 2'b01) begin //ori
    ALUSignal <= 3'b010;
    end
    //////////////////////////////////// new ////////////////////////////
    else if(ALUOp == 2'b11) begin //beq, bne
    ALUSignal <= 3'b001;
    end
    ////////////////////////////////////////////////////////////////////
    else
    ALUSignal <= 0;

end

endmodule

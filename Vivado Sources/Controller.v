`timescale 1ns / 1ps
    /*
OPTIONS: 
1. Send full instruction anyway
2. Only send opcode (bits 31:26) and deal with increments as individual cases along with the 21st? bit and 6th bit in another controller 
3. Send opcode and 21st bit and 6th bit.
NOTE: NEED TO THINK ABOUT WHAT THINGS TO MAKE X
*/

module Controller(Instruction, Bit17, RegWrite, AluSrc, RegDst, MemWrite, MemRead, MemtoReg, PCSrc, AluOp, SEControl, Comp_Control, jal_Control, j_Control, jORjal);
    input [5:0] Instruction;
    input Bit17;
    output reg RegWrite, AluSrc, RegDst, MemWrite,  MemRead, MemtoReg, PCSrc, SEControl, Comp_Control, jal_Control, j_Control, jORjal;
    output reg [1:0] AluOp; //This will be sent to the AluControl. 
    
    initial begin
        SEControl <= 0;
        RegWrite <= 0;
        AluSrc <= 0;
        RegDst <= 0; 
        MemWrite <= 0;
        MemRead <= 0;
        MemtoReg <= 0; 
        PCSrc <= 0;
        AluOp <= 0;
        SEControl <= 0;
        Comp_Control <= 0;
        jal_Control <= 0;
        j_Control <= 0;
    end
    
    always @ (*) begin
        jORjal <= 0;
        j_Control <= 0;
        jal_Control <= 0;
        Comp_Control <= 0;
        SEControl <= 1;
        if(Instruction == 0) begin //a normal R-type instruction
            RegWrite <= 1;
            AluSrc <= 0;
            RegDst <= 1; //Since rd is located on bits 15-11.
            //We have nothing to do with memory here. 
            MemWrite <= 0;
            MemRead <= 0;
            MemtoReg <= 1; //NOTE: Logically it should be 0, but according to the datapath provided it should be 1 in this case. 
            PCSrc <= 0;
            AluOp <= 2'b00;
        end
        else if (Instruction == 6'b001101) begin //ori
            SEControl <= 0;
            RegWrite <= 1;
            AluSrc <= 1;
            RegDst <= 0; //Since rd is located on bits 20-16.
            //We have nothing to do with memory here. 
            MemWrite <= 0;
            MemRead <= 0;
            MemtoReg <= 1; //NOTE: Logically it should be 0, but according to the datapath provided it should be 1 in this case. 
            PCSrc <= 0;
            AluOp <= 2'b01;
        end
        else if (Instruction == 6'b001000) begin //addi
            RegWrite <= 1;
            AluSrc <= 1;
            RegDst <= 0; //Since rd is located on bits 20-16.
            //We have nothing to do with memory here. 
            MemWrite <= 0;
            MemRead <= 0;
            MemtoReg <= 1; //NOTE: Logically it should be 0, but according to the datapath provided it should be 1 in this case. 
            PCSrc <= 0;
            AluOp <= 2'b10;
        end
        
        else if (Instruction == 6'b100011) begin //lw
            RegWrite <= 1;
            AluSrc <= 1; //Since we are using immediate field. 
            RegDst <= 0; //Since rd is located on bits 20-16. 
            MemWrite <= 0;
            MemRead <= 1;
            MemtoReg <= 0;
            PCSrc <= 0; //Since we are not jumping
            AluOp <= 2'b10; //Since we are just doing addition. 
         end
         /*
        else if (Instruction == 6'b100000) begin //lb
            RegWrite <= 1;
            AluSrc <= 1;
            RegDst <= 0; //Since rd is located on bits 20-16. 
            MemWrite <= 0;
            MemRead <= 1; //Cause we are writing to register.
            MemtoReg <= 0; //DOES NOT MATTER
            PCSrc <= 0; //Since we are not jumping
            AluOp <= 6; //Since we are just doing addition. 
            LS_SEControl <= 0;
            LS_Control <= 1;
        end*/
        else if (Instruction == 6'b101011) begin //sw
            RegWrite <= 0;
            AluSrc <= 1;
            RegDst <= 0; //Since we want rt to go through. 
            MemWrite <= 1;
            MemRead <= 0;
            MemtoReg <= 0; //DOES NOT MATTER 
            PCSrc <= 0; //Since we are not jumping
            AluOp <= 2'b10;
        end
        else if (Instruction == 6'b000100) begin //beq
            RegWrite <= 0;
            AluSrc <= 0; //This does matter here since we are comparing two fields.
            RegDst <= 0; //Since rd is located on bits 20-16.
            //We have nothing to do with memory here. 
            MemWrite <= 0;
            MemRead <= 0;
            MemtoReg <= 0; //DOES NOT MATTER 
            PCSrc <= 1; //Since we want to branch. 
            AluOp <= 2'b11;
        end
        else if (Instruction == 6'b000101) begin //bne
            RegWrite <= 0;
            AluSrc <= 0; //This does matter here since we are comparing two fields.
            RegDst <= 0; //Since rd is located on bits 20-16.
            //We have nothing to do with memory here. 
            MemWrite <= 0;
            MemRead <= 0;
            MemtoReg <= 0; //DOES NOT MATTER 
            PCSrc <= 1; //Since we want to branch. 
            AluOp <= 2'b11; //Since we just invert the zero signal from beq operation.
            Comp_Control <= 1;
        end
        else if (Instruction == 6'b000010) begin //j
            jORjal <= 1;
            j_Control <= 1; //
            RegWrite <= 0; //DOES NOT MATTER
            AluSrc <= 0; //DOES NOT MATTER
            RegDst <= 0; //DOES NOT MATTER
            MemWrite <= 0; //DOES NOT MATTER
            MemRead <= 0; //DOES NOT MATTER
            MemtoReg <= 0; //DOES NOT MATTER
            PCSrc <= 0; //DOES NOT MATTER
            AluOp <= 0; //DOES NOT MATTER
        end
        else if (Instruction == 6'b000011) begin //jal
            jORjal <= 1;
            j_Control <= 1;
            RegWrite <= 1;  
            AluSrc <= 1; //DOES NOT MATTER
            RegDst <= 0; //DOES NOT MATTER
            MemWrite <= 0; //DOES NOT MATTER
            MemRead <= 0; //DOES NOT MATTER
            MemtoReg <= 1; //DOES NOT MATTER 
            PCSrc <= 0; //DOES NOT MATTER
            AluOp <= 0; //DOES NOT MATTER
            jal_Control <= 1; 
        end
        else begin
            RegWrite <= 0;
            AluSrc <= 0;
            RegDst <= 0; 
            MemWrite <= 0;
            MemRead <= 0;
            MemtoReg <= 0; 
            PCSrc <= 0;
            AluOp <= 0;
        end
        
    end

endmodule
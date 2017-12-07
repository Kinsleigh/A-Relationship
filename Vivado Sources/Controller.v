/*
OPTIONS: 
1. Send full instruction anyway
2. Only send opcode (bits 31:26) and deal with increments as individual cases along with the 21st? bit and 6th bit in another controller 
3. Send opcode and 21st bit and 6th bit.
NOTE: NEED TO THINK ABOUT WHAT THINGS TO MAKE X
*/

module Controller(Instruction, Bit17, RegWrite, AluSrc, RegDst, MemWrite, MemRead, MemtoReg, PCSrc, AluOp, SEControl, LS_SEControl, LS_Control, Comp_Control, jal_Control, j_Control, jORjal, D_MemWrite_S);
	input [5:0] Instruction;
	input Bit17;
	output reg RegWrite, AluSrc, RegDst, MemWrite,  MemRead, MemtoReg, PCSrc, SEControl, LS_SEControl, LS_Control, Comp_Control, jal_Control, j_Control, jORjal;
    output reg [1:0] D_MemWrite_S;
	output reg [3:0] AluOp; //This will be sent to the AluControl. 
	
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
        LS_SEControl <= 0;
        LS_Control <= 0; 
        Comp_Control <= 0;
        jal_Control <= 0;
        j_Control <= 0;
        D_MemWrite_S <= 0;
	end
	
	always @ (*) begin
	    jORjal <= 0;
        j_Control <= 0;
        jal_Control <= 0;
        Comp_Control <= 0;
		SEControl <= 1;
		LS_SEControl <= 0;
        LS_Control <= 0;
		D_MemWrite_S <= 0;
		if(Instruction == 0) begin //a normal R-type instruction
			RegWrite <= 1;
			AluSrc <= 0;
			RegDst <= 1; //Since rd is located on bits 15-11.
			//We have nothing to do with memory here. 
			MemWrite <= 0;
			MemRead <= 0;
			MemtoReg <= 1; //NOTE: Logically it should be 0, but according to the datapath provided it should be 1 in this case. 
			PCSrc <= 0;
			AluOp <= 0;
		end
		else if (Instruction == 6'b011100) begin //mul operations
			RegWrite <= 0; //This will change for mul though, as determined by ALU Control.
			AluSrc <= 0;
			RegDst <= 1; //Since rd is located on bits 15-11.
			//We have nothing to do with memory here.
			MemWrite <= 0;
			MemRead <= 0;
			MemtoReg <= 1; //NOTE: Logically it should be 0, but according to the datapath provided it should be 1 in this case. 
			PCSrc <= 0; //Cause no jump. 
			AluOp <= 1;
		end
		else if (Instruction == 6'b011111) begin //seh & seb
			RegWrite <= 1; 
			AluSrc <= 0;
			RegDst <= 1; //Since rd is located on bits 15-11.
			//We have nothing to do with memory here. 
			MemWrite <= 0;
			MemRead <= 0;
			MemtoReg <= 1; //NOTE: Logically it should be 0, but according to the datapath provided it should be 1 in this case. 
			PCSrc <= 0;
			AluOp <= 2;
		end
		else if (Instruction == 6'b001100) begin //andi
			SEControl <= 0; //cause we zero extend this one. 
			RegWrite <= 1;
			AluSrc <= 1;
			RegDst <= 0; //Since rd is located on bits 20-16.
			//We have nothing to do with memory here. 
			MemWrite <= 0;
			MemRead <= 0;
			MemtoReg <= 1; //NOTE: Logically it should be 0, but according to the datapath provided it should be 1 in this case. 
			PCSrc <= 0;
			AluOp <= 3;
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
			AluOp <= 4;
		end
		else if (Instruction == 6'b001110) begin //xori
			SEControl <= 0;
			RegWrite <= 1;
			AluSrc <= 1;
			RegDst <= 0; //Since rd is located on bits 20-16.
			//We have nothing to do with memory here. 
			MemWrite <= 0;
			MemRead <= 0;
			MemtoReg <= 1; //NOTE: Logically it should be 0, but according to the datapath provided it should be 1 in this case. 
			PCSrc <= 0;
			AluOp <= 5;
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
			AluOp <= 6;
		end
		else if (Instruction == 6'b001001) begin //addiu
			RegWrite <= 1;
			AluSrc <= 1;
			RegDst <= 0; //Since rd is located on bits 20-16.
			//We have nothing to do with memory here. 
			MemWrite <= 0;
			MemRead <= 0;
			MemtoReg <= 1; //NOTE: Logically it should be 0, but according to the datapath provided it should be 1 in this case. 
			PCSrc <= 0;
			AluOp <= 7;
		end
		else if (Instruction == 6'b001010) begin //slti
			RegWrite <= 1;
			AluSrc <= 1;
			RegDst <= 0; //Since rd is located on bits 20-16.
			//We have nothing to do with memory here. 
			MemWrite <= 0;
			MemRead <= 0;
			MemtoReg <= 1; //NOTE: Logically it should be 0, but according to the datapath provided it should be 1 in this case. 
			PCSrc <= 0;
			AluOp <= 8;
		end
		else if (Instruction == 6'b001011) begin //sltiu
			RegWrite <= 1;
			AluSrc <= 1;
			RegDst <= 0; //Since rd is located on bits 20-16.
			//We have nothing to do with memory here. 
			MemWrite <= 0;
			MemRead <= 0;
			MemtoReg <= 1; //NOTE: Logically it should be 0, but according to the datapath provided it should be 1 in this case. 
			PCSrc <= 0;
			AluOp <= 9;
		end
		else if (Instruction == 6'b001111) begin //lui
            RegWrite <= 1;
            AluSrc <= 1; //since we are using the immediate field aka the last 16 bits. 
            RegDst <= 0; //Since rd is located on bits 15-11.
            //We have nothing to do with memory here. 
            MemWrite <= 0;
            MemRead <= 0;
            MemtoReg <= 1; //NOTE: Logically it should be 0, but according to the datapath provided it should be 1 in this case. 
            PCSrc <= 0; //Since we are not jumping
            AluOp <= 10;
        end
        else if (Instruction == 6'b100011) begin //lw
            RegWrite <= 1;
            AluSrc <= 1; //Since we are using immediate field. 
            RegDst <= 0; //Since rd is located on bits 20-16. 
            MemWrite <= 0;
            MemRead <= 1;
            MemtoReg <= 0;
            PCSrc <= 0; //Since we are not jumping
            AluOp <= 6; //Since we are just doing addition. 
         end
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
        end
        else if (Instruction == 6'b100001) begin //lh
            RegWrite <= 1;
            AluSrc <= 1;
            RegDst <= 1; //Since rd is located on bits 15-11.
            MemWrite <= 0;
            MemRead <= 1;
            MemtoReg <= 0; //DOES NOT MATTER
            PCSrc <= 0; //Since we are not jumping
            AluOp <= 6; //Since we are just doing addition. 
            LS_SEControl <= 1; //Since we are doing a halfword
            LS_Control <= 1; //Since we are doing a byte/halfword
        end
        else if (Instruction == 6'b101011) begin //sw
            RegWrite <= 0;
            AluSrc <= 1;
            RegDst <= 0; //Since we want rt to go through. 
            MemWrite <= 1;
            MemRead <= 0;
            MemtoReg <= 0; //DOES NOT MATTER 
            PCSrc <= 0; //Since we are not jumping
            AluOp <= 6;
        end
        else if (Instruction == 6'b101000) begin //sb
            RegWrite <= 0;
            AluSrc <= 1;
            RegDst <= 0; //Since we want rt to go through. 
            MemWrite <= 1;
            D_MemWrite_S <= 1;
            MemRead <= 0;
            MemtoReg <= 0; //DOES NOT MATTER 
            PCSrc <= 0;
            AluOp <= 6;
            LS_SEControl <= 0; //Since we are doing a byte
            LS_Control <= 1;   //Since we are doing a byte/halfword
        end
        else if (Instruction == 6'b101001) begin //sh
            RegWrite <= 0;
            AluSrc <= 1; //Since we are using immediate field.
            RegDst <= 0; //Since we want rt to go through. 
            MemWrite <= 1;
            D_MemWrite_S <= 2;
            MemRead <= 0;
            MemtoReg <= 0; //DOES NOT MATTER
            PCSrc <= 0; //Since we are not jumping
            AluOp <= 6;
            LS_SEControl <= 1;
            LS_Control <= 1;
        end
        else if (Instruction == 6'b000111) begin //bgtz if (rs > 0) branch
            RegWrite <= 0;
            AluSrc <= 0;
            RegDst <= 0; //Since rd is located on bits 20-16.
            //We have nothing to do with memory here. 
            MemWrite <= 0;
            MemRead <= 0;
            MemtoReg <= 0; //NOTE: Logically it should be 0, but according to the datapath provided it should be 1 in this case. 
            PCSrc <= 1;
            AluOp <= 11;
        end
        else if (Instruction == 6'b000110) begin //blez if(rs <= 0) branch
            RegWrite <= 0;
            AluSrc <= 0; //DOES NOT MATTER
            RegDst <= 0; //DOES NOT MATTER
            //We have nothing to do with memory here. 
            MemWrite <= 0;
            MemRead <= 0;
            MemtoReg <= 0; //DOES NOT MATTER
            PCSrc <= 1; //Since we want to branch.
            AluOp <= 11; //Since we just invert the zero signal from bgtz operation.
            Comp_Control <= 1;
        end
        else if (Instruction == 6'b000001) begin //bltz or bgez
            if(Bit17) begin //bgez if(rs >= 0) branch
                RegWrite <= 0;
                AluSrc <= 0;    //DOES NOT MATTER
                RegDst <= 0; //DOES NOT MATTER
                //We have nothing to do with memory here. 
                MemWrite <= 0;
                MemRead <= 0;
                MemtoReg <= 1; //DOES NOT MATTER
                PCSrc <= 1; //Since we want to branch. 
                AluOp <= 12;//Since we just invert the zero signal from bltz operation.
                Comp_Control <= 1;
            end
            else begin //bltz if(rs < 0) branch
                RegWrite <= 0;
                AluSrc <= 0;    //DOES NOT MATTER
                RegDst <= 0; //DOES NOT MATTER
                //We have nothing to do with memory here. 
                MemWrite <= 0;
                MemRead <= 0;
                MemtoReg <= 1; //DOES NOT MATTER
                PCSrc <= 1; //Since we want to branch. 
                AluOp <= 12;
            end
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
            AluOp <= 13;
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
            AluOp <= 13; //Since we just invert the zero signal from beq operation.
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
`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// Names: Kinsleigh Wong, Zahra Sadeq
// Percent Effort : 50 - 50
// Module - ALU32Bit.v
// Description - 32-Bit wide arithmetic logic unit (ALU).
//
// INPUTS:-
// ALUControl: 4-Bit input control bits to select an ALU operation.
// A: 32-Bit input port A.
// B: 32-Bit input port B.
//
// OUTPUTS:-
// ALUResult: 32-Bit ALU result output.
// ZERO: 1-Bit output flag. s
//
// FUNCTIONALITY:-
// Design a 32-Bit ALU behaviorally, so that it supports addition,  subtraction,
// AND, OR, and set on less than (SLT). The 'ALUResult' will output the 
// corresponding result of the operation based on the 32-Bit inputs, 'A', and 
// 'B'. The 'Zero' flag is high when 'ALUResult' is '0'. The 'ALUControl' signal 
// should determine the function of the ALU based on the table below:-
// Op   | 'ALUControl' value
// ==========================
// AND  | 00000 0
// OR   | 00001 1
// ADD  | 00010 2
// MADD | 00011 3
// NOR  | 00100 4
// XOR  | 00101 5
// SUB  | 00110 6
// SLT  | 00111 7
// SLL  | 01000 8
// MUL  | 01001 9
// MOVN | 01010 10
// MOVZ | 01011 11
// MSUB | 01100 12
// SRL  | 01101 13 
// ROTR | 01110 14
// SRA  | 01111 15
// MTHI | 10000 16
// bgtz & blez | 10001 17 needs to be tested
// MFHI | 10010 18
// LUI  | 10011 19 
// SEB  | 10100 20
// SEH  | 10101 21
// MULT | 10110 22
// MFLO | 10111 23
// MTLO | 11000 24
// bltz or bgez | 11001 25 needs to be tested

//      | 11010
//      | 11011
//      | 11100
//      | 11101
//      | 11110
//      | 11111 
// NOTE:-
// SLT (i.e., set on less than): ALUResult is '32'h000000001' if A < B.
// 

module ALU32Bit(ALUControl, A, B, ALUResult, Zero, UnsignedSignal);

	input [4:0] ALUControl; // control bits for ALU operation
	input [31:0] A, B;	    // inputs
    input UnsignedSignal;
	output reg [31:0] ALUResult;	// answer rd[15:11]
	//output reg [63:0] ALUResultOne ; //this is 64 bits, first 32 is hi, second 32 is low
	output Zero;	    // Zero=1 if ALUResult == 0

	initial begin
		ALUResult <= 0;
	end
	
	always @(*) begin
        ALUResult <= 0;
		if (ALUControl == 5'b00010) begin  //add
		  //A is rs [25:21]
		  //B is rt [20:16]
			if (UnsignedSignal == 1)begin
			     ALUResult <= A + B; 
			end
			else begin
			     ALUResult <= $signed(A) + $signed(B); 
			end
			
		end
		else if(ALUControl == 5'b00110) begin //sub
		  //A is rs [25:21]
		  //B is rt [20:16]
			ALUResult <= $signed(A)-$signed(B); 
		end
		else if(ALUControl == 5'b00000) begin //and
		  //A is rs [25:21]
		  //B is rt[20:16]
			ALUResult <= A & B; 
		end
		else if(ALUControl == 5'b00001) begin //or
		  //A is rs [25:21]
		  //B is rt [20:16]
			ALUResult <= A | B; 
		end
		else if (ALUControl == 5'b00111) begin //slt
	      //A is rs [25:21]
          //B is rt [20:16]
		    if ($signed(A) < $signed(B)) begin //slt
				ALUResult <= 1;
			end
			else begin
				ALUResult <= 0;
			end
		end
		else if(ALUControl == 5'b00100)begin //NOR
		  //A is rs [25:21]
          //B is rt [20:16]
		    ALUResult <= ~(A|B);
		end
		else if (ALUControl == 5'b00101)begin //XOR
		  //A is rs [25:21]
          //B is rt [20:16]
		    ALUResult <= (A^B);
		end
		else if(ALUControl == 5'b01000)begin // SLL
		   //B is rt [20:16] 
		   //A is sa [10:6]
		    ALUResult <= B << A;
		end
    else if(ALUControl == 5'b01010)begin // MOVN
      //A is rs [25: 21]
      //B is rt [20:16]
        if(B != 0)begin
            ALUResult <= A;
        end
    end
        else if(ALUControl == 5'b01011 )begin // MOVZ
          //A is rs [25: 21]
          //B is rt [20:16]
            if(B == 0)begin
                ALUResult <= A;
            end
        end
        else if(ALUControl == 5'b01101 )begin // SRL
          //B is rt [20:16]
          //A is sa [10:6]
            ALUResult <= B>>A;
        end 
        else if(ALUControl == 5'b01110)begin  //ROTR
          //B is rt [20:16]
          //A is sa [10:6]
          //y = (x << n) | (x >> (32 - n));
           ALUResult <= (B << (32 - A)) | (B >> A);
        end
        else if( ALUControl == 5'b01111) begin //SRA 
          //B is rt [20:16]
          //A is sa [10:6]
            ALUResult <= $signed(B) >>> A;
        end          
        else if(ALUControl == 5'b10100) begin  //SEB
          //B is rt [20:16]     
          if(B[7] == 0)begin
              ALUResult  <= {24'h0 , B[7:0]};
          end
          else begin
              ALUResult  <= {24'hffffff , B[7:0]};
           //   ALUResult  <= {24'b1 , B[7:0]};
          end
        end
        else if( ALUControl == 5'b10101)begin //SEH
          //B is rt [20:16]    
          if(B[15] == 0)begin
              ALUResult  <= {16'b0,B[15:0]};
          end
          else begin
              ALUResult  <= {16'b1,B[15:0]};
          end
          
        end    
        //////////////////////////// new /////////////////////////////////
        else if(ALUControl == 5'b10001)begin //bgtz & blez 
            if($signed(A) > 0)begin //bgtz
                ALUResult <= 0;
            end
            else begin
                ALUResult <= 1;
            end
        end
        else if(ALUControl == 5'b11001)begin //bltz or bgez 
            if($signed(A) < 0)begin // bltz
                ALUResult <= 0;
            end
            else begin
                ALUResult <= 1;
            end
        end
        else if(ALUControl == 5'b10011)begin //LUI  
            ALUResult <= {B[15:0], 16'b0}; 
        end 
	end

    assign Zero = (ALUResult == 0);
endmodule

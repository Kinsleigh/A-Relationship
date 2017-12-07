`timescale 1ns / 1ps



module HazardDetection(IDEXMemRead, IDEXRegWrite,JR_OPcode,OPCode, IDEXRD,IFIDRT, IFIDRS, IDEXRT, MuxEn, PCWrite, IFIDWrite, IDEXWrite, EXMEMWrite, Branch, FlushSignal, jORjal, ALU_jr, jORjal_D);
	input IDEXMemRead, IDEXRegWrite, jORjal, ALU_jr, jORjal_D;
	input [5:0] JR_OPcode, OPCode;
	input [4:0] IFIDRT, IFIDRS, IDEXRT, IDEXRD;
    input Branch;
	output reg PCWrite, IFIDWrite, MuxEn, IDEXWrite, EXMEMWrite, FlushSignal;
	
	initial begin
	   PCWrite <= 0;
       IFIDWrite <= 0;  
       IDEXWrite <= 0;
       EXMEMWrite <=0;
       FlushSignal <= 0;
       MuxEn <= 0;
	end 
	 
	always @(*)begin 
	    PCWrite <= 0;
        IFIDWrite <= 0;
        IDEXWrite <= 0;  
        EXMEMWrite <= 0;
        FlushSignal <= 0;
        MuxEn <= 0;
        if( (Branch) || (jORjal) || ( ALU_jr) )begin
            PCWrite <= 0;
            IFIDWrite <= 0;
            IDEXWrite <= 0;
            EXMEMWrite <= 0;
            FlushSignal <= 1;
            MuxEn <= 0;
        end
	   //load followed by anything (no jr or sw)
	   if((!((IDEXRT == IFIDRT)&&((OPCode == 6'b100011)||(OPCode == 6'b100001)||(OPCode == 6'b100000))))&&(!((OPCode == 6'b101011)||(OPCode == 6'b101000)||(OPCode == 6'b101001)))&&(IDEXMemRead) &&(IDEXRegWrite) && ((IDEXRT == IFIDRT)||(IDEXRT == IFIDRS)) && !jORjal_D)begin 
	      PCWrite <= 1;
          IFIDWrite <= 1;
          IDEXWrite <= 0;
          MuxEn <= 1;
          EXMEMWrite <= 0;
          FlushSignal <= 0; 
	   end 

	   //lw followed by lw when it uses the same base
	   if(((OPCode == 6'b100011)||(OPCode == 6'b100001)||(OPCode == 6'b100000) )&& (IDEXMemRead) && (IDEXRegWrite) && (IDEXRT == IFIDRS) )begin 
	          PCWrite <= 1;
              IFIDWrite <= 1;
              IDEXWrite <= 0;
              MuxEn <= 1;
              EXMEMWrite <= 0;
              FlushSignal <= 0; 
	   end
	   //lw followed by sw when it uses the base
	   if((IDEXMemRead) && (IDEXRegWrite) && ((OPCode == 6'b101011) || (OPCode == 6'b101000) || (OPCode == 6'b101001)) && (IDEXRT == IFIDRS))begin
           PCWrite <= 1;                         
           IFIDWrite <= 1;
           MuxEn <= 1;
           IDEXWrite <= 0;
           EXMEMWrite <= 0; 
           FlushSignal <= 0;
        end
        
	   //load followed by a unconditional branch ,(jr) 
	   //basically jr only cause jal and j dont check for anything 
	   //NOW REMEMBER: jumps and branches happen in the EXECUTE stage, therefore stall ONLY ONCE!
	   if((JR_OPcode == 6'b001000 && OPCode == 6'b000000) && (IDEXRegWrite) && (IDEXMemRead) && (IDEXRT == IFIDRS) && IDEXRT != 0)begin
	      PCWrite <= 1;
          IFIDWrite <= 1;
          EXMEMWrite <= 1;
          MuxEn <= 1; 
          IDEXWrite <= 0;
          FlushSignal <= 0;
	   end 

	end

endmodule 

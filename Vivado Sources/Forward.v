module Forward(
	input [4:0] IDEX_Reg1, IDEX_Reg2, IDEX_RegDes, EXMEM_RegDes, MEMWB_RegDes,
	input IDEX_MemWrite, IDEX_jr,
	input EXMEM_RegWrite, EXMEM_MemRead, EXMEM_MemWrite,
	input MEMWB_RegWrite, MEMWB_MemRead, 
	output reg [1:0] E_MuxAlu_1, E_MuxAlu_2, E_jrMux,
	output reg E_MuxWriteData);


	initial begin
		E_MuxAlu_1 <= 0;
		E_MuxAlu_2 <= 0;
		E_MuxWriteData <= 0;
		E_jrMux <= 0;
	end

	always @(*) begin
		E_MuxAlu_1 <= 0;
		E_MuxAlu_2 <= 0;
		E_MuxWriteData <= 0;
		E_jrMux <= 0;

		/*
		Case 1:
		add $t1, etc
		add etc, $t1
		Solution:
		Either forward to first or second input of the ALU from MEM stage.
		*/
		if(IDEX_Reg1 == EXMEM_RegDes && EXMEM_RegWrite && EXMEM_RegDes != 0)
			E_MuxAlu_1 <= 1;

		if(IDEX_Reg2 == EXMEM_RegDes && EXMEM_RegWrite && EXMEM_RegDes != 0)
			E_MuxAlu_2 <= 1;

		/*
		Case 2:
		add $t1, etc
		nop
		add etc, $t1
		Solution:
		Either forward to first or second input of the ALU from WB stage, assuming no forwarding from MEM stage.
		*/
		if(IDEX_Reg1 == MEMWB_RegDes && MEMWB_RegWrite && (EXMEM_RegDes != MEMWB_RegDes || !EXMEM_RegWrite) && MEMWB_RegDes != 0)
			E_MuxAlu_1 <= 2;
		if(IDEX_Reg2 == MEMWB_RegDes && MEMWB_RegWrite && (EXMEM_RegDes != MEMWB_RegDes || !EXMEM_RegWrite) && MEMWB_RegDes != 0)
			E_MuxAlu_2 <= 2;

		//NOTE: For sw, it might forward, but since we put the forward mux before the other decision muxes we gucci. 

		/*
		Case 3:
		add $t1, etc
		sw $t1, etc

		OR 

		lw $t1, etc
		sw $t1, etc
		SOLUTION:
		We forward to the MEM stage from the WB stage, and have a mux for the the thing that will go into the WriteData port for DataMemory. 
		*/
		//FOR SAVES NEED TO MAKE THE DESTINATION REGISTER RT SO I CAN USE IT
		if(EXMEM_MemWrite && EXMEM_RegDes == MEMWB_RegDes && MEMWB_RegWrite && MEMWB_RegDes != 0)
			E_MuxWriteData <= 1;

		/*
		Case 4:
		add $t1, etc
		nop
		sw $t1, etc
		SOLUTION: 
		We forward to the EX stage from the WB stage to the WriteData for DataMemory. 
		*/
		if(IDEX_MemWrite && IDEX_RegDes == MEMWB_RegDes && MEMWB_RegWrite && (MEMWB_RegDes != EXMEM_RegDes || !EXMEM_RegWrite) && IDEX_RegDes != 0)
			E_MuxAlu_2 <= 2;

		/*
		Case 5:
		lw $t1, etc
		nop
		add etc, $t1

		SOLUTION:
		We forward to the EX stage from the WB stage. 
		*/
		if(MEMWB_MemRead && IDEX_Reg1 == MEMWB_RegDes && (EXMEM_RegDes != MEMWB_RegDes || !EXMEM_RegWrite) && IDEX_Reg1 != 0)
			E_MuxAlu_1 <= 2;
		if(MEMWB_MemRead && IDEX_Reg2 == MEMWB_RegDes && (EXMEM_RegDes != MEMWB_RegDes || !EXMEM_RegWrite) && IDEX_Reg2 != 0)
			E_MuxAlu_2 <= 2;

		/*
		Case 6:
		add $t1, etc
		jr $t1
		SOLUTION:
		We need to forward from MEM stage to EX stage to the jr mux. 
		*/

		if(IDEX_jr && IDEX_Reg1 == EXMEM_RegDes && EXMEM_RegWrite && EXMEM_RegDes != 0)
			E_jrMux <= 1;

		/*
		Case 7:
		add $t1, etc
		nop
		jr $t1
		
		OR

		lw $t1, etc
		nop //This should be done by the stall. 
		jr $t1

		SOLUTION:
		We need to forward from WB stage to EX stage to the jr mux. 
		*/
		if(IDEX_jr && IDEX_Reg1 == MEMWB_RegDes && MEMWB_RegWrite && MEMWB_RegDes != 0 && (EXMEM_RegDes != MEMWB_RegDes || !EXMEM_RegWrite))
			E_jrMux <= 2;

	end

endmodule
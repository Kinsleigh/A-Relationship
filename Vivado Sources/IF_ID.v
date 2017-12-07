/*
Kinsleigh Wong

This module implements the IF/ID register  file. 

*/

module IF_ID(Clk, Instruction_In, NextInstruction_In, Instruction_Out, NextInstruction_Out, IFIDWrite, FlushSignal);
    input Clk;
    input IFIDWrite, FlushSignal;
    input [31:0] Instruction_In, NextInstruction_In;
    output [31:0] Instruction_Out, NextInstruction_Out;
	
    reg [31:0] Regis [0:1];
    
	initial begin
		Regis[0] <= 0;
		Regis[1] <= 0;
	end
	
    always @(posedge Clk) begin
      if ((IFIDWrite == 0) && (FlushSignal == 0)) begin
		  Regis[0] <= Instruction_In;
		  Regis[1] <= NextInstruction_In;
	 end
	  else if(IFIDWrite)begin
          Regis[0] <= Regis[0];
          Regis[1] <= Regis[1];
      end
      else if(FlushSignal)begin
          Regis[0] <= 0;
          Regis[1] <= 0;
      end
	end  
      
    assign Instruction_Out = Regis[0];
	assign NextInstruction_Out = Regis[1];
    
endmodule

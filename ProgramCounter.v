module ProgramCounter(Clk, Reset, Address, PCResult, PCEnable);

	input PCEnable;
	input [31:0] Address;
	input Reset, Clk;

	output reg [31:0] PCResult;
	
	initial begin
	   PCResult <= 0;
	end
	
	/* Please fill in the implementation here... */
	
	always @(posedge Clk) begin
		if (Reset == 1)
			PCResult <= 0;
		else
			if (PCEnable == 0)
				PCResult <= Address;
			else 
			    PCResult <= PCResult;
	end

endmodule
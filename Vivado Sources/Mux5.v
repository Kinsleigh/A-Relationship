module Mux5(In1, In2, Control, Out);
	input [4:0] In1, In2;
	input Control;
	output reg [4:0] Out;

	initial begin
		Out <= 0;
	end
	
	always @(*)begin
		if(Control)
			Out <= In2;
		else
			Out <= In1;
	
	end
	
endmodule
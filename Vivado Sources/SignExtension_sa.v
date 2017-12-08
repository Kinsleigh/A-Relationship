module SignExtension_sa(In, Out);
	input [4:0] In;
	output reg [31:0] Out;
	
	initial begin
	Out <= 0;
	end 
	
	always @(*) begin
		Out <= {27'b0, In};
	end
	
endmodule
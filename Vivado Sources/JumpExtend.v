module JumpExtend(
	input [3:0] NI,
	input [25:0] Instr,
	output reg [31:0] JumpE);

	initial begin
		JumpE <= 0;
	end
	
	always @(*)begin
		JumpE <= {NI, Instr, 2'b00};
	end
	
endmodule
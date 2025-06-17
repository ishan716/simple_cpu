module flowcontrol(JUMP, BRANCH, ZERO, OUT);

	//Input and output port declaration
	input JUMP, BRANCH, ZERO;
	output OUT;
	
	//Assigns OUT based on values of JUMP, BRANCH and ZERO using simple combinational logic
	assign OUT = JUMP | (BRANCH & ZERO);

endmodule
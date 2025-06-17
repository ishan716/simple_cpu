module flowcontrol(BJSELECT, ZERO, OUT);

	//Input and output port declaration
	input [1:0] BJSELECT;
	input ZERO;
	output OUT;
	
	//Assigns OUT based on values of JUMP, BRANCH and ZERO using simple combinational logic
	assign OUT = BJSELECT[0] ^ (BJSELECT[1] & ZERO);

endmodule

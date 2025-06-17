module jumpbranchAdder(PC, OFFSET, TARGET);
	
	//Declaration of input and output ports
	input [31:0] PC;
	input [7:0] OFFSET;
	output [31:0] TARGET;
	
	wire [21:0] signBits;		//Bus to store extended sign bits
	
	assign signBits = {22{OFFSET[7]}};	//assigning the sign bit (MSB) of OFFSET to all 22 bits in signBits
	
	//GENERATING TARGET address by adding the OFFSET * 4 to the PC value after a delay of 2 time units
	//First 22 bits contain the extended sign bits, next 8 bits contain the actual offset, the next two bits are zeros due to shifting left by 2 (multiplication by 4)
	assign #2 TARGET = PC + {signBits, OFFSET, 2'b0};	
	
endmodule
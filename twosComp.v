
module twosComp(IN, OUT);

	//Declaration of input and output ports
	input [7:0] IN;
	output [7:0] OUT;
	
	//Combinational logic to assign two's complement value of input to output after a delay of #1
	assign #1 OUT = ~IN + 1;

endmodule
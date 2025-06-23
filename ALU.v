//time delay case

//forward output A
//add/sub output B
//and output C
//or output D
//mult output E

`include "mult.v"
`include "shift.v"

//forward module
module forwardUnit(input  [7:0] op2, output reg [7:0] A );
    always @(op2)
        #1 A = op2;
endmodule

//add and sub module
module addsubUnit(input signed[7:0] op1, input signed[7:0] op2, output reg signed[7:0] B );
    always @(op1 or op2)
        #1 B = op1 + op2;
endmodule

//and gate
module andUnit(input [7:0] op1, input [7:0] op2, output reg [7:0] C );
    always @(op1 or op2)
    
        C =  op1 & op2;
    
endmodule    

//or gate
module orUnit(input [7:0] op1, input  [7:0] op2, output reg [7:0] D );
    always @(op1 or op2)
         D = op1 | op2;
endmodule  


//mux to select the output according to the units
module muxUnit(input [7:0] A,input [7:0] B,input [7:0] C,input [7:0] D,input[7:0] E,input[7:0] F,input[7:0] G, input [2:0] select,output reg [7:0] result);
    always @(A or B or C or D or select)
    if (select == 3'b000)
        result = A;
    else if (select == 3'b001)
        result = B;
    else if (select == 3'b010)
       #2 result = C;
    else if (select == 3'b011)
        #1 result = D;
    else if(select==3'b110)
        result=E;
    else if(select==3'b101)
        result=F;
    else if(select==3'b111)
        result=G;

endmodule

//logicSelect unit to combine the results of units
module logicSelector(input [7:0] op1, input [7:0] op2,input [2:0] select,output [7:0] result,output zero);
    wire [7:0] A,B,C,D,E,F,G;

    

    forwardUnit forwardUnit1(op2,A);
    addsubUnit addsub1(op1,op2,B);
    andUnit and1(op1,op2,C);
    orUnit or1(op1,op2,D);
    mult mult1(op1,op2,E);
    left_shift shift1(op1,op2,F);
    right_shift shift2(op1,op2,G);
    muxUnit mux1(A,B,C,D,E,F,G,select,result);
    

		
	//This section of the ALU contains the combinational logic to generate the ZERO output
	assign zero = ~(result[0] | result[1] | result[2] | result[3] | result[4] | result[5] | result[6] | result[7]);

endmodule

//TestBench
/*module testbench;
    reg signed[7:0] op1,op2;    //use signed for output negatives
    reg [3:0] select;
    wire signed[7:0] result;        //use signed for output negatives

    logicSelector Selector1(op1,op2,select,result);

    initial begin
        $dumpfile("waveformALU.vcd");
        $dumpvars(0, testbench); //dump all the signals from tb to hierachy level 0
        $monitor("Time = %0t | op1 = %d | op2 = %d | select = %b | result = %d", $time, op1, op2, select, result);
        op1 = 8'd3; op2 = 8'd1; select =  4'b0000;      //forward 1
        #5 op1 = 8'd3; op2 = 8'd1; select = 4'b0001;    //add 4
        #5 op1 = 8'sd3; op2 = -8'sd7; select = 4'b0001; //sub -7+3=-4
        #5 op1 = 8'd3; op2 = 8'd1; select = 4'b0010;    //and 1
        #5 op1 = 8'd3; op2 = 8'd1; select = 4'b0011;    //or 3
        #10;
        
    end
endmodule*/








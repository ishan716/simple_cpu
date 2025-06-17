`include "cpu.v"

module cpu_tb;

    reg CLK, RESET;
    wire [31:0] PC;
    wire [31:0] INSTRUCTION;
    
    // TODO: Initialize an array of registers (8x1024) named 'instr_mem' to be used as instruction memory
	reg [7:0] instr_mem [1023:0];
    
    // TODO: Create combinational logic to support CPU instruction fetching, given the Program Counter(PC) value 
    //       (make sure you include the delay for instruction fetching here)
	assign #2 INSTRUCTION = {instr_mem[PC+3], instr_mem[PC+2], instr_mem[PC+1], instr_mem[PC]};
    
    initial
    begin
        // Initialize instruction memory with the set of instructions you need execute on CPU
        
        // METHOD 1: manually loading instructions to instr_mem
        // 0x00: loadi r1, 0x03      // r1 = 3
{instr_mem[3], instr_mem[2], instr_mem[1], instr_mem[0]} = 
32'b00000000_00000001_00000000_00000011;

// 0x04: loadi r2, 0x03      // r2 = 3
{instr_mem[7], instr_mem[6], instr_mem[5], instr_mem[4]} = 
32'b00000000_00000010_00000000_00000011;

// 0x08: beq r1, r2, 0x03     // if r1 == r2, skip next 3 instructions
{instr_mem[11], instr_mem[10], instr_mem[9], instr_mem[8]} = 
32'b00000111_00000011_00000001_00000010;

// 0x0C: loadi r3, 0x09       // skipped if r1 == r2
{instr_mem[15], instr_mem[14], instr_mem[13], instr_mem[12]} = 
32'b00000000_00000011_00000000_00001001;

// 0x10: loadi r4, 0x0A       // skipped if r1 == r2
{instr_mem[19], instr_mem[18], instr_mem[17], instr_mem[16]} = 
32'b00000000_00000100_00000000_00001010;

// 0x14: loadi r5, 0x01       // r5 = 1 (used for incrementing)
{instr_mem[23], instr_mem[22], instr_mem[21], instr_mem[20]} = 
32'b00000000_00000101_00000000_00000001;

// 0x18: add r1, r1, r2       // r1 = r1 + r5
{instr_mem[27], instr_mem[26], instr_mem[25], instr_mem[24]} = 
32'b00000010_00000001_00000001_00000010;

// 0x1C: mov r0, r1           // move r1 to r0
{instr_mem[31], instr_mem[30], instr_mem[29], instr_mem[28]} = 
32'b00000001_00000000_00000000_00000001;

// 0x20: jmp 0x01             // go back to the beq instruction (loop)
{instr_mem[35], instr_mem[34], instr_mem[33], instr_mem[32]} = 
32'b00000110_00000001_00000000_00000000;

// 0x18: add r5, r1, r2       // r1 = r1 + r5
{instr_mem[39], instr_mem[38], instr_mem[37], instr_mem[36]} = 
32'b00000010_00000101_00000001_00000010;

// 0x1C: mov r5, r0           // move r1 to r0
{instr_mem[43], instr_mem[42], instr_mem[41], instr_mem[40]} = 
32'b00000001_00000101_00000000_00000000;


        
        // beq r4, r5   
        //{instr_mem[27], instr_mem[26], instr_mem[25], instr_mem[24]} = 32'b00000111_00000000_00000110_00000000;

        // j    
        //{instr_mem[31], instr_mem[30], instr_mem[29], instr_mem[28]} = 32'b00000110_00000000_00000000_00010000;
        
    end
    
    /* 
    -----
     CPU
    -----
    */
    cpu mycpu(PC, INSTRUCTION, CLK, RESET);

    integer i;

    initial
    begin
    
        // generate files needed to plot the waveform using GTKWave
        $dumpfile("cpu_wavedata.vcd");
		$dumpvars(0, cpu_tb);
        for (i =0 ;i<8 ;i++ ) begin
            $dumpvars(1, cpu_tb.mycpu.my_reg.REGISTER[i]);
        end
        
        CLK = 1'b0;
        RESET = 1'b0;
        
        // TODO: Reset the CPU (by giving a pulse to RESET signal) to start the program execution
		RESET = 1'b1;
		#5
		RESET = 1'b0;
        
        // finish simulation after some time
        #500
        $finish;
        
    end
    
    // clock signal generation
    always
        #4 CLK = ~CLK;
        

endmodule
`include "ALU.v"
`include "control_unit.v"
`include "mux.v"
`include "reg_file.v"
`include "twosComp.v"
`include "flowcontrol.v"
`include "mux32.v"
`include "pcAdder.v"
`include "jumpbranchAdder.v"

module cpu (
    output reg [31:0] pc,
    input [31:0] instruction,
    input clk, reset
);

    wire mux1op, mux2op, writeable, jump, branch;
    wire [2:0] aluop;
    wire [7:0] opcode;

    control_unit my_cu(
        .opcode(opcode),
        .writeable(writeable),
        .aluop(aluop),
        .mux1op(mux1op),
        .mux2op(mux2op),
        .jump(jump),
        .branch(branch)
    );

    wire [2:0] readreg1, readreg2, writereg;
    wire [7:0] regout1, regout2;

    reg_file my_reg(
        .in(aluresult),
        .out1(regout1),
        .out2(regout2),
        .inaddress(writereg),
        .out1address(readreg1),
        .out2address(readreg2),
        .write(writeable),
        .clk(clk),
        .reset(reset)
    );

    wire [7:0] operand2, aluresult;
    wire [7:0] negatedOp, mux1out, immediate;
    wire zero;

    logicSelector my_alu(regout1, operand2, aluop, aluresult, zero);
    twosComp my_twosComp(regout2, negatedOp);
    mux mux1(regout2, negatedOp, mux1op, mux1out);
    mux mux2(mux1out, immediate, mux2op, operand2);

    wire [31:0] PCplus4;
    pcAdder my_pcAdder(pc, PCplus4);

    wire [31:0] target;
    wire [7:0] offset;

    jumpbranchAdder my_jumpbranchAdder(PCplus4, offset, target);

    wire flowselect;
    flowcontrol my_flowcontrol(jump, branch, zero, flowselect);

    wire [31:0] PCout;
    mux32 flowctrlmux(PCplus4, target, flowselect, PCout);

    assign opcode    = instruction[31:24];
    assign writereg  = instruction[23:16];
    assign readreg1  = instruction[15:8];
    assign readreg2  = instruction[7:0];
    assign immediate = instruction[7:0];
    assign offset    = instruction[23:16];

    // PC Update
    always @ (posedge clk) begin
        if (reset == 1'b1) begin
            #1 pc = 0;           // Reset PC
        end else begin
            #1 pc = PCout;       // Update PC
        end
    end

endmodule

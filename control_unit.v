module control_unit(
    input [7:0] opcode,
    output reg writeable,
    output reg [2:0] aluop,
    output reg mux1op,
    output reg mux2op,
    output reg [1:0] bselect
);

    always @(opcode) begin
        // Default values to prevent latches
        aluop     = 3'b000;
        mux1op    = 1'b0;
        mux2op    = 1'b0;
        writeable = 1'b0;
        bselect   =2'b00;

        #1;
        case (opcode)
            8'b00000000: begin // loadi
                aluop     = 3'b000;
                mux1op    = 1'b0;
                mux2op    = 1'b1;
                bselect   =2'b00;
                writeable = 1'b1;
            end
            8'b00000001: begin // mov
                aluop     = 3'b000;
                mux1op    = 1'b0;
                mux2op    = 1'b0;
                 bselect   =2'b00;
                writeable = 1'b1;
            end
            8'b00000010: begin // add
                aluop     = 3'b001;
                mux1op    = 1'b0;
                mux2op    = 1'b0;
                 bselect   =2'b00;
                writeable = 1'b1;
            end
            8'b00000011: begin // sub
                aluop     = 3'b010;
                mux1op    = 1'b1;
                mux2op    = 1'b0;
                 bselect   =2'b00;
                writeable = 1'b1;
            end
            8'b00000100: begin // and
                aluop     = 3'b011;
                mux1op    = 1'b0;
                mux2op    = 1'b0;
                 bselect   =2'b00;
                writeable = 1'b1;
            end
            8'b00000101: begin // or
                aluop     = 3'b100;
                mux1op    = 1'b0;
                mux2op    = 1'b0;
                 bselect   =2'b00;
                writeable = 1'b1;
            end
            8'b00000110: begin // j
                bselect   =2'b01;
                writeable = 1'b0;
            end
            8'b00000111: begin // beq
                aluop     = 3'b001;
                mux2op    = 1'b0;
                mux1op    = 1'b1;
                bselect   =2'b10;
                writeable = 1'b0;
            end
            8'b00001000: begin // bne
                aluop     = 3'b001;
                mux2op    = 1'b0;
                mux1op    = 1'b1;
                bselect   =2'b11;
                writeable = 1'b0;
            end
            8'b00001001:begin //mult
                aluop=3'b110;
                mux2op=1'b0;
                mux1op=1'b0;
                bselect=2'b00;
                writeable=1'b1;
            end
            8'b00001010:begin //sll
                aluop=3'b101;
                mux2op=1'b1;
                mux1op=1'b0;
                bselect=2'b00;
                writeable=1'b1;
            end
            8'b00001011:begin //srl
                aluop=3'b111;
                mux2op=1'b1;
                mux1op=1'b0;
                bselect=2'b00;
                writeable=1'b1;
            end
            8'b00001100:begin //sra
                aluop=3'b111;
                mux2op=1'b1;
                mux1op=1'b0;
                bselect=2'b00;
                writeable=1'b1;
            end
            8'b00001101:begin //ror
                aluop=3'b111;
                mux2op=1'b1;
                mux1op=1'b0;
                bselect=2'b00;
                writeable=1'b1;
            end


            default: begin // unknown instruction
                // already set by default values
            end
        endcase
    end

endmodule

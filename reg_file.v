module reg_file(in, out1, out2, inaddress, out1address, out2address, write, clk, reset);

    input [7:0] in;
    input [2:0] inaddress, out1address, out2address; 
    output [7:0] out1, out2;

    input write,clk,reset;

    reg [7:0] arr [7:0];

    assign #2 out1 = arr[out1address];
    assign #2 out2 = arr[out2address];

    integer i;

    always @(posedge clk) begin
        
        if (reset == 1'b1) begin
            #1
            for (i = 0; i < 8; i = i + 1) begin
                arr[i] <= 8'b00000000;
            end
        end else if (write == 1'b1) begin
            #1 arr[inaddress] <= in;
        end
    end

    initial begin
        $monitor($time, "\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d", arr[0], arr[1], arr[2], arr[3], arr[4], arr[5], arr[6], arr[7]);
    end

    initial begin
    $dumpvars(0, arr[0]);
    $dumpvars(0, arr[1]);
    $dumpvars(0, arr[2]);
    $dumpvars(0, arr[3]);
    $dumpvars(0, arr[4]);
    $dumpvars(0, arr[5]);
    $dumpvars(0, arr[6]);
    $dumpvars(0, arr[7]);
end


endmodule

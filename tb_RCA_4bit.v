`timescale 1ns / 1ps
`timescale 1ns/1ps

module RCA_4bit_tb;

    // Testbench signals
    reg en;
    reg [3:0] A;
    reg [3:0] B;
    reg Cin;

    wire [3:0] Sum;
    wire Carry;

    // Instantiate DUT
    RCA_4bit DUT (
        .en(en),
        .A(A),
        .B(B),
        .Cin(Cin),
        .Sum(Sum),
        .Carry(Carry)
    );

    // Task to apply a test vector
    task apply;
        input [3:0] a;
        input [3:0] b;
        input cin;
        input enable;
        begin
            A = a;
            B = b;
            Cin = cin;
            en = enable;
            #10;
        end
    endtask

    initial begin
        // Dump for GTKWave
        $dumpfile("RCA_4bit.vcd");
        $dumpvars(0, RCA_4bit_tb);

        // Initial values
        A = 0; B = 0; Cin = 0; en = 0;
        #10;

        // Enable = 0 ? output must be zero
        apply(4'd5, 4'd3, 1'b0, 1'b0);
        apply(4'd9, 4'd6, 1'b1, 1'b0);

        // Enable = 1 ? normal addition
        apply(4'd3, 4'd2, 1'b0, 1'b1);   // 3 + 2 = 5
        apply(4'd7, 4'd4, 1'b0, 1'b1);   // 7 + 4 = 11
        apply(4'd15,4'd1, 1'b0, 1'b1);   // 15 + 1 = 16
        apply(4'd8, 4'd7, 1'b1, 1'b1);   // 8 + 7 + 1 = 16
        apply(4'd10,4'd5, 1'b1, 1'b1);   // 10 + 5 + 1 = 16

        // Random tests
        repeat (10) begin
            apply($random, $random, $random, 1'b1);
        end

        #20;
        $finish;
    end

    // Monitor output
    initial begin
        $monitor("T=%0t | en=%b A=%d B=%d Cin=%b | Sum=%d Carry=%b",
                 $time, en, A, B, Cin, Sum, Carry);
    end

endmodule


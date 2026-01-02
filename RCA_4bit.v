`timescale 1ns/1ps

module RCA_4bit(
    input en,   //enable
    input wire [3:0] A, input wire [3:0] B, input Cin,
    output wire [3:0] Sum, output Carry
);

    wire w1; wire w2; wire w3; wire w4;
    
    FA_HA_1bit f0 (
        .en(en),
        .A(A[0]),
        .B(B[0]),
        .Cin(Cin),
        .Sum(Sum[0]),
        .Carry(w1));

    FA_HA_1bit f1 (
        .en(en),
        .A(A[1]),
        .B(B[1]),
        .Cin(w1),
        .Sum(Sum[1]),
        .Carry(w2));

    FA_HA_1bit f2 (
        .en(en),
        .A(A[2]),
        .B(B[2]),
        .Cin(w2),
        .Sum(Sum[2]),
        .Carry(w3));

    FA_HA_1bit f3 (
        .en(en),
        .A(A[3]),
        .B(B[3]),
        .Cin(w3),
        .Sum(Sum[3]),
        .Carry(w4));
   
   assign Carry = w4;
    
        
        
endmodule
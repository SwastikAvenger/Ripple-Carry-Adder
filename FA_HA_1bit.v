`timescale 1ns / 1ps

module FA_HA_1bit(
        input en,
        input A, input B, input Cin,
        output Sum, output Carry
    );
    
    wire s1;
    wire c1;
    
    HA_1bit d0 (
        .en(en),
        .A(A),
        .B(B),
        .S(s1),
        .C(c1));
    
    wire c2;

    HA_1bit d1 (
        .en(en),
        .A(s1),
        .B(Cin),
        .S(Sum),
        .C(c2));
    assign Carry = c1 | c2; 
endmodule

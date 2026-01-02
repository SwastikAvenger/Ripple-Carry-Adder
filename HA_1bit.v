`timescale 1ns/1ps

module HA_1bit(
    input wire en,
    input wire A, input wire B,
    output wire S, output wire C
);
    assign S = en ? (A ^ B) : 1'b0;
    assign C = en ? (A & B) : 1'b0;

endmodule
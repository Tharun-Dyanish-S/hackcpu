`timescale 1ns/1ns

module HalfAdder (output S, output C, input A, input B);
  xor (S, A, B);
  and (C, A, B);

endmodule

module FullAdder (output S, output Cout, input A, input B, input Cin);

  HalfAdder h1 (S_temp, C_temp, A, B);
  HalfAdder h2 (S, temp_C, S_temp, Cin);
  or or1 (Cout, temp_C, C_temp);

endmodule

module Propogate (output P, input A, input B);
  xor (P, A, B);

endmodule

module Generate (output G, input A, input B);
  and (G, A, B);

endmodule

module CLA4 (output [3:0] S, output [4:0] C, input [3:0] A, input [3:0] B, input Cin);
  wire [3:0] G,P;
  Generate g1[3:0] (G, A, B);
  Propogate p1[3:0] (P, A, B);
  
  and (P0C0, P[0], Cin);
  or (C[1], P0C0, G[0]);
  
  and (P1P0C0, P[1], P[0], Cin);
  and (P1G0, P[1], G[0]);
  or (C[2], P1P0C0, P1G0, G[1]);
  
  and (P2P1P0C0, P[2], P[1], P[0], Cin);
  and (P2P1G0, P[2], P[1], G[0]);
  and (P2G1, P[2], G[1]);
  or (C[3], P2P1P0C0, P2P1G0, P2G1, G[2]);

  and (P3P2P1P0C0, P[3], P[2], P[1], P[0], Cin);
  and (P3P2P1G0, P[3], P[2], P[1], G[0]);
  and (P3P2G1, P[3], P[2], G[1]);
  and (P3G2, P[3], G[2]);
  or (C[4], P3P2P1P0C0, P3P2P1G0, P3P2G1, P3G2, G[3]);

  buf(C[0], Cin);
  xor x1 [3:0] (S[3:0], P[3:0], C[3:0]);    //mighterror

endmodule

module CLA8 (output [7:0] S, output Cout, input [7:0] A, input [7:0] B, input Cin);

  wire [4:0] C1;
  wire [4:0] C2;
  
  CLA4 c1 (S[3:0], C1 [4:0], A[3:0], B[3:0], Cin);
  CLA4 c2 (S[7:4], C2 [4:0], A[7:4], B[7:4], C1[4]);

  buf b1 (Cout, C2[4]);

endmodule

module CLAS8 (output[7:0] S, output Cout, input[7:0] A, input[7:0] B);
    wire [7:0] notB;
    not n1[7:0] (notB, B);

    CLA8 claass8 (S, Cout, A, notB, 1'b1);

endmodule

module Compa (output[7:0] isnotequal, input[7:0] A, B);
  xor x1[7:0] (isnotequal,A,B);
endmodule
`timescale 1ns/1ns

module Propo (output P, input A, input B);
  not (notA, A);
  or (P, notA, B);

endmodule

module Geno (output G, input A, input B);
  not (notA, A);
  and (G, notA, B);

endmodule

module BLS4 (output [3:0] D, input [3:0] A, input [3:0] B);
  wire [3:0] G,P;
  wire [4:0] Bout;
  Geno g1[3:0] (G, A, B);
  Propo p1[3:0] (P, A, B);
  buf (Bout[1], G[0]);

  and (P1G0, P[1], G[0]);
  or (Bout[2], P1G0, G[1]);

  and (P2P1G0, P[2], P[1], G[0]);
  and (P2G1, P[2], G[1]);
  or (Bout[3], P2P1G0, P2G1, G[2]);

  and (P3P2P1G0, P[3], P[2], P[1], G[0]);
  and (P3P2G1, P[3], P[2], G[1]);
  and (P3G2, P[3], G[2]);
  or (Bout[4], P3P2P1G0, P3P2G1, P3G2, G[3]);

  buf (Bout[0], 1'b0);

  xor x1 [3:0] (D[3:0], A[3:0], B[3:0], Bout[3:0]);    //mighterror

endmodule

module BLS5 (output [4:0] D, output Boutt, input Bin, input [4:0] A, input [4:0] B);
  wire [4:0] G,P;
  wire [5:0] Bout;
  buf (Bout[0], Bin);
  
  Geno g1[4:0] (G, A, B);
  Propo p1[4:0] (P, A, B);

  and (P0B0, P[0], Bout[0]);
  or (Bout[1],P0B0, G[0]);

  
  and (P1P0B0, P[1], P[0], Bout[0]);
  and (P1G0, P[1], G[0]);
  or (Bout[2], P1P0B0, P1G0, G[1]);

  and (P2P1P0B0, P[2], P[1], P[0], Bout[0]);
  and (P2P1G0, P[2], P[1], G[0]);
  and (P2G1, P[2], G[1]);
  or (Bout[3], P2P1P0B0, P2P1G0, P2G1, G[2]);

  and (P3P2P1P0B0, P[3], P[2], P[1], P[0], Bout[0]);
  and (P3P2P1G0, P[3], P[2], P[1], G[0]);
  and (P3P2G1, P[3], P[2], G[1]);
  and (P3G2, P[3], G[2]);
  or (Bout[4], P3P2P1P0B0, P3P2P1G0, P3P2G1, P3G2, G[3]);

  and (P4P3P2P1P0B0, P[4], P[3], P[2], P[1], P[0], Bout[0]);
  and (P4P3P2P1G0, P[4], P[3], P[2], P[1], G[0]);
  and (P4P3P2G1, P[4], P[3], P[2], G[1]);
  and (P4P3G2, P[4], P[3], G[2]);
  and (P4G3, P[4], G[3]);
  or (Bout[5], P4P3P2P1P0B0, P4P3P2P1G0, P4P3P2G1, P4P3G2, P4G3, G[4]);

  buf (Boutt, Bout[5]);

  xor x1 [4:0] (D[4:0], A[4:0], B[4:0], Bout[4:0]);    //mighterror

endmodule
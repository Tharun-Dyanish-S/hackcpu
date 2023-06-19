`timescale 1ns/1ns

module CLA16l (output [15:0] S, output [1:0] Cout, input [15:0] A, input [15:0] B, input Cin);

  wire [4:0] C1;
  wire [4:0] C2;
  wire [4:0] C3;
  wire [4:0] C4;
  
  CLA4 c1 (S[3:0], C1 [4:0], A[3:0], B[3:0], Cin);
  CLA4 c2 (S[7:4], C2 [4:0], A[7:4], B[7:4], C1[4]);
  CLA4 c3 (S[11:8], C3 [4:0], A[11:8], B[11:8], C2[4]);
  CLA4 c4 (S[15:12], C4 [4:0], A[15:12], B[15:12], C3[4]);

  buf b1[1:0] (Cout[1:0], C4[4:3]);

endmodule

module IUl (output OF, output [15:0] S, input [15:0] A, input [15:0] B, input op, input sig);

  wire [15:0] notB;
  xor x2[15:0] (notB[15:0], B[15:0], op);    //op==1 => Sub

  wire [1:0] Cout;
  CLA16l c161 (S, Cout, A, notB, op);
  //OF = (Cout[1] ^ (Cout[0] & sig) ^ (op& ~sig);
  and (coutsig, Cout[0], sig);
  xor (OF_temp, Cout[1], coutsig);
  not (notsig, sig);
  and (opsig, op, notsig);
  xor (OF, OF_temp, opsig);

endmodule

module CLA16h (output [15:0] S, output [1:0] Cout, input [15:0] A, input [15:0] B, input Cin);
  wire [15:0] G,P;
  Generate g1[15:0] (G, A, B);
  Propogate p1[15:0] (P, A, B);

  wire [3:0] PI;
  wire [3:0] GI;

  and (PI[0], P[3], P[2], P[1], P[0]);
  and (PI[1], P[7], P[6], P[5], P[4]);
  and (PI[2], P[11], P[10], P[9], P[8]);
  and (PI[3], P[15], P[14], P[13], P[12]);


  and (P3P2P1G0, P[3], P[2], P[1], G[0]);
  and (P3P2G1, P[3], P[2], G[1]);
  and (P3G2, P[3], G[2]);
  or (GI[0], P3P2P1G0, P3P2G1, P3G2, G[3]);

  and (P3P2P1G0a, P[7], P[6], P[5], G[4]);
  and (P3P2G1a, P[7], P[6], G[5]);
  and (P3G2a, P[7], G[6]);
  or (GI[2], P3P2P1G0a, P3P2G1a, P3G2a, G[7]);

  and (P3P2P1G0b, P[11], P[10], P[9], G[8]);
  and (P3P2G1b, P[11], P[10], G[9]);
  and (P3G2b, P[11], G[10]);
  or (GI[2], P3P2P1G0b, P3P2G1b, P3G2b, G[11]);
  
  and (P3P2P1G0c, P[15], P[14], P[13], G[12]);
  and (P3P2G1c, P[15], P[14], G[13]);
  and (P3G2c, P[15], G[14]);
  or (GI[3], P3P2P1G0c, P3P2G1c, P3G2c, G[15]);


  wire [4:1] C;
  
  
  and (P0C0i, PI[0], Cin);
  or (C[1], P0C0i, GI[0]);
  
  and (P1P0C0i, PI[1], PI[0], Cin);
  and (P1G0i, PI[1], GI[0]);
  or (C[2], P1P0C0i, P1G0i, GI[1]);
  
  and (P2P1P0C0i, PI[2], PI[1], PI[0], Cin);
  and (P2P1G0i, PI[2], PI[1], GI[0]);
  and (P2G1i, PI[2], GI[1]);
  or (C[3], P2P1P0C0i, P2P1G0i, P2G1i, GI[2]);

  and (P3P2P1P0C0i, PI[3], PI[2], PI[1], PI[0], Cin);
  and (P3P2P1G0i, PI[3], PI[2], PI[1], GI[0]);
  and (P3P2G1i, PI[3], PI[2], GI[1]);
  and (P3G2i, PI[3], GI[2]);
  or (C[4], P3P2P1P0C0i, P3P2P1G0i, P3P2G1i, P3G2i, GI[3]);

  wire [4:0] C1, C2, C3, C4;
  
  CLA4 c1 (S[3:0], C1 [4:0], A[3:0], B[3:0], Cin);
  CLA4 c2 (S[7:4], C2 [4:0], A[7:4], B[7:4], C[1]);
  CLA4 c3 (S[11:8], C3 [4:0], A[11:8], B[11:8], C[2]);
  CLA4 c4 (S[15:12], C4 [4:0], A[15:12], B[15:12], C[3]);

  buf b1[1:0] (Cout[1:0], C4[4:3]);

endmodule

module IUh (output OF, output [15:0] S, input [15:0] A, input [15:0] B, input op, input sig);

  wire [15:0] notB;
  xor x2[15:0] (notB[15:0], B[15:0], op);    //op==1 => Sub

  wire [1:0] Cout;
  CLA16l c162 (S, Cout, A, notB, op);
  //OF = (Cout[1] ^ (Cout[0] & sig);
  and (coutsig, Cout[0], sig);
  xor (OF_temp, Cout[1], coutsig);
  not (notsig, sig);
  and (opsig, op, notsig);
  xor (OF, OF_temp, opsig);

endmodule
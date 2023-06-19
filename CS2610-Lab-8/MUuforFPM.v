`timescale 1ns/1ns

module MUu1(output [15:0] Sum1, input [7:0] A, B);
  wire [7:0][15:0] PP;
  and a1[7:0] (PP[0][7:0], A[7:0], B[0]);
  and a2[7:0] (PP[1][8:1], A[7:0], B[1]);
  and a3[7:0] (PP[2][9:2], A[7:0], B[2]);
  and a4[7:0] (PP[3][10:3], A[7:0], B[3]);
  and a5[7:0] (PP[4][11:4], A[7:0], B[4]);
  and a6[7:0] (PP[5][12:5], A[7:0], B[5]);
  and a7[7:0] (PP[6][13:6], A[7:0], B[6]);
  and a8[7:0] (PP[7][14:7], A[7:0], B[7]);

  buf b1[15:8] (PP[0][15:8], 1'b0);
  buf b2[15:9] (PP[1][15:9], 1'b0);
  buf b3[15:10] (PP[2][15:10], 1'b0);
  buf b4[15:11] (PP[3][15:11], 1'b0);
  buf b5[15:12] (PP[4][15:12], 1'b0);
  buf b6[15:13] (PP[5][15:13], 1'b0);
  buf b7[15:14] (PP[6][15:14], 1'b0);
  buf b8 (PP[7][15], 1'b0);
  
  buf b10 (PP[1][0], 1'b0);
  buf b11[1:0] (PP[2][1:0], 1'b0);
  buf b12[2:0] (PP[3][2:0], 1'b0);
  buf b13[3:0] (PP[4][3:0], 1'b0);
  buf b14[4:0] (PP[5][4:0], 1'b0);
  buf b15[5:0] (PP[6][5:0], 1'b0);
  buf b16[6:0] (PP[7][6:0], 1'b0);

  csa16u csu (Sum1, OF, PP);  
endmodule

`timescale 1ns/1ns

module ttt (output [15:0] S1, output [15:0] S2, input [15:0] A, input [15:0] B, input [15:0] C);
  
  wire [16:1] Cii;
  FullAdder f1 [15:0]  (S1[15:0], Cii[16:1], A[15:0], B[15:0], C[15:0]);
  buf b1 [15:1] (S2[15:1], Cii[15:1]);    //check if adds properly for signed
  buf b2 (S2[0], 0);

endmodule

module csa16u (output [15:0] Sum, output OF, input [7:0][15:0] PP);
  wire [15:0] M1,M2,M3,M4,R1,R2,R3,R4, S1, S2, T1, T2;
   ttt t1 (M1, M2, PP[0], PP[1], PP[2]);
  ttt t2 (M3, M4, PP[3], PP[4], PP[5]);

  
  ttt t4 (R1, R2, PP[6], PP[7], M1);
  ttt t5 (R3, R4, M2, M3, M4);

  ttt t6 (S1, S2, R1, R2, R3);

  ttt t7 (T1, T2, R4, S1, S2);

  IUl iuh1 (OF1, Sum, T1, T2, 1'b0, 1'b0);

  or (OF, Sum[15], Sum[14], Sum[13], Sum[12], Sum[11], Sum[10], Sum[9], Sum[8]);
  
endmodule

// module IUl (output OF, output [15:0] S, input [15:0] A, input [15:0] B, input op, input sig);

//   wire [15:0] notB;
//   xor x2[15:0] (notB[15:0], B[15:0], op);    //op==1 => Sub

//   wire [1:0] Cout;
//   CLA16l c162 (S, Cout, A, notB, op);
//   //OF = (Cout[1] ^ (Cout[0] & sig);
//   and (coutsig, Cout[0], sig);
//   xor (OF_temp, Cout[1], coutsig);
//   not (notsig, sig);
//   and (opsig, op, notsig);
//   xor (OF, OF_temp, opsig);

// endmodule

// module CLA16l (output [15:0] S, output [1:0] Cout, input [15:0] A, input [15:0] B, input Cin);

//   wire [4:0] C1;
//   wire [4:0] C2;
//   wire [4:0] C3;
//   wire [4:0] C4;
  
//   CLA4 c1 (S[3:0], C1 [4:0], A[3:0], B[3:0], Cin);
//   CLA4 c2 (S[7:4], C2 [4:0], A[7:4], B[7:4], C1[4]);
//   CLA4 c3 (S[11:8], C3 [4:0], A[11:8], B[11:8], C2[4]);
//   CLA4 c4 (S[15:12], C4 [4:0], A[15:12], B[15:12], C3[4]);

//   buf b1[1:0] (Cout[1:0], C4[4:3]);

// endmodule
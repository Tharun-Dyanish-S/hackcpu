`timescale 1ns/1ns

// module ttt (output [15:0] S1, output [15:0] S2, input [15:0] A, input [15:0] B, input [15:0] C);
  
//   wire [16:1] Cii;
//   FullAdder f1 [15:0]  (S1[15:0], Cii[16:1], A[15:0], B[15:0], C[15:0]);
//   buf b1 [15:1] (S2[15:1], Cii[15:1]);    //check if adds properly for signed
//   buf b2 (S2[0], 0);

// endmodule

// module csa16u (output [15:0] Sum, output OF, input [7:0][15:0] PP);
//   wire [15:0] M1,M2,M3,M4,R1,R2,R3,R4, S1, S2, T1, T2;
//    ttt t1 (M1, M2, PP[0], PP[1], PP[2]);
//   ttt t2 (M3, M4, PP[3], PP[4], PP[5]);

  
//   ttt t4 (R1, R2, PP[6], PP[7], M1);
//   ttt t5 (R3, R4, M2, M3, M4);

//   ttt t6 (S1, S2, R1, R2, R3);

//   ttt t7 (T1, T2, R4, S1, S2);

//   IUh iuh1 (OF1, Sum, T1, T2, 1'b0, 1'b0);

//   or (OF, Sum[15], Sum[14], Sum[13], Sum[12], Sum[11], Sum[10], Sum[9], Sum[8]);
  
// endmodule

module csa16s (output [15:0] Sum, output OF1, output OF2, input [7:0][15:0] PP);
  wire [15:0] M1,M2,M3,M4,R1,R2,R3,R4, S1, S2, T1, T2, U1, U2;
  ttt t1 (M1, M2, PP[0], PP[1], PP[2]);
  ttt t2 (M3, M4, PP[3], PP[4], PP[5]);

  
  ttt t3 (R1, R2, PP[6], PP[7], M1);
  ttt t4 (R3, R4, M2, M3, M4);

  ttt t5 (S1, S2, R1, R2, R3);

  ttt t6 (T1, T2, R4, S1, S2);

  ttt t7 (U1, U2, T1, T2, 16'b0000000010000000);

  IUh iuh1 (OFt, Sum, U1, U2, 1'b0, 1'b1);

  or (OF1, Sum[15], Sum[14], Sum[13], Sum[12], Sum[11], Sum[10], Sum[9], Sum[8]);

  wire [15:8] notSum;
  not n1[15:8] (notSum, Sum[15:8]);
  or or1 (OF2, notSum[15], notSum[14], notSum[13], notSum[12], notSum[11], notSum[10], notSum[9], notSum[8]);
  
endmodule
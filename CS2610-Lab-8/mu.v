`timescale 1ns/1ns

module MUu(output [7:0] PS, output OF, input [7:0] A, B);
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

  wire [15:0] Sum1;
  csa16u csu (Sum1, OF, PP);  
  
  buf b11111[7:0] (PS[7:0], Sum1[7:0]);
  
endmodule

module MUs(output [7:0] PS, output OF, input [7:0] A, B);
  wire [7:0][15:0] PP;
  and a1[7:0] (PP[0][7:0], A[7:0], B[0]);
  and a2[7:0] (PP[1][8:1], A[7:0], B[1]);
  and a3[7:0] (PP[2][9:2], A[7:0], B[2]);
  and a4[7:0] (PP[3][10:3], A[7:0], B[3]);
  and a5[7:0] (PP[4][11:4], A[7:0], B[4]);
  and a6[7:0] (PP[5][12:5], A[7:0], B[5]);
  and a7[7:0] (PP[6][13:6], A[7:0], B[6]);

  wire [7:0] andA;
  and a8[7:0] (andA[7:0], A[7:0], B[7]);
  not n1[7:0] (PP[7][14:7], andA[7:0]);
  

  buf b1[15:8] (PP[0][15:8], PP[0][7]);
  buf b2[15:9] (PP[1][15:9], PP[1][8]);
  buf b3[15:10] (PP[2][15:10], PP[2][9]);
  buf b4[15:11] (PP[3][15:11], PP[3][10]);
  buf b5[15:12] (PP[4][15:12], PP[4][11]);
  buf b6[15:13] (PP[5][15:13], PP[5][12]);
  buf b7[15:14] (PP[6][15:14], PP[6][13]);
  buf b8 (PP[7][15], PP[7][14]);
  
  buf b10 (PP[1][0], 1'b0);
  buf b11[1:0] (PP[2][1:0], 1'b0);
  buf b12[2:0] (PP[3][2:0], 1'b0);
  buf b13[3:0] (PP[4][3:0], 1'b0);
  buf b14[4:0] (PP[5][4:0], 1'b0);
  buf b15[5:0] (PP[6][5:0], 1'b0);
  buf b16[6:0] (PP[7][6:0], 1'b0);

  wire [15:0] Sum1;
  csa16s css (Sum1, OF1, OF2, PP);  

  xor x1 (xorr, A[7], B[7]);
  not x2 (xnorr, xorr);

  and andof (OF11, OF1, xnorr);
  and andon (OF12, OF2, xorr);

  or orof (OF, OF11, OF12);
  
  buf b11111[7:0] (PS[7:0], Sum1[7:0]);
  
endmodule
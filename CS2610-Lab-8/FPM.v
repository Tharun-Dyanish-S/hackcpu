`timescale 1ns/1ns

module FPM (output OF, output [11:0] Prod, input [11:0] X , input[11:0] Y);
  wire [3:0] Xe, Ye;
  wire [7:0] Xm, Ym;
  wire Xs, Ys;
  
  buf (Xs, X[11]);
  buf (Ys, Y[11]);
  xor (Prod[11], Xs, Ys);

  buf b1[3:0] (Xe, X[10:7]);
  buf b2[3:0] (Ye, Y[10:7]);
  wire [4:0] Sum;
  wire [4:0] cout;
  CLA4 cla1 (Sum[3:0], cout, Xe, Ye, 1'b0);
  buf (Sum[4], cout[4]);
  
  wire [4:0] sub1, sub2;
  BLS5 BLS1 (sub1, Bout1, 1'b0, Sum, 5'b00111);
  BLS5 BLS2 (sub2, Bout2, 1'b0, Sum, 5'b00110);

  buf b3[6:0] (Xm[6:0], X[6:0]);
  buf b4[6:0] (Ym[6:0], Y[6:0]);
  buf (Xm[7], 1'b1);
  buf (Ym[7], 1'b1);
  wire [15:0] Pm;
  MUu1 muu1 (Pm, Xm, Ym);

  mux_2to1_4bit mux1 (sub1[3:0], sub2[3:0], Pm[15], Prod[10:7]);
  mux_2to1_7bit mux2 (Pm[13:7], Pm[14:8], Pm[15], Prod[6:0]);

  or (OF1, sub1[4], Bout1);
  or (OF2, sub2[4], Bout2);

  mux_2to1_1bit mux3 (OF1, OF2, Pm[15], OF);
  
endmodule
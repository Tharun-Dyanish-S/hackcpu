`timescale 1ns/1ns

module FPA (output [11:0] Z, input [11:0] X,Y);
  wire Zs, Xs, Ys;
  wire [3:0] Ze, Xe, Ye;
  wire [6:0] Zm, Xm, Ym;

  buf b1 (Xs, X[11]);
  buf b2 [3:0] (Xe, X[10:7]);
  buf b3 [6:0] (Xm, X[6:0]);

  buf b4 (Ys, Y[11]);
  buf b5 [3:0] (Ye, Y[10:7]);
  buf b6 [6:0] (Ym, Y[6:0]);
  
  wire [3:0] k;
  BLS4 BLS1 (k, Xe, Ye);

  wire [7:0] Xmwith1;
  buf b7 [6:0] (Xmwith1[6:0], Xm);
  buf b8 (Xmwith1[7], 1'b1);

  wire [7:0] Ymwith1;
  buf b9 [6:0] (Ymwith1[6:0], Ym);
  buf b10 (Ymwith1[7], 1'b1);
  
  wire [7:0] Yshift;
  BarrelShift BS1 (Yshift, Ymwith1, k[2:0]);

  wire [7:0] Yshift1;
  mux_2to1_8bit mu21_8 (Yshift, 8'b0, k[3], Yshift1);

  wire [0:8] SM;
  CLA8 cla8 (SM[1:8], SM[0], Xmwith1, Yshift1, 1'b0);

  mux_2to1_7bit m2 (SM[2:8], SM[1:7], SM[0], Zm);

  wire [3:0] Xeplus1;
  wire [4:0] tempcarry;
  CLA4 cla4 (Xeplus1, tempcarry, Xe, 4'b0, 1'b1);

  mux_2to1_4bit mu21_4 (Xe, Xeplus1, SM[0], Ze);

  buf b100 (Z[11], 1'b0);
  buf b101 [3:0] (Z[10:7], Ze);
  buf b102 [6:0] (Z[6:0], Zm);
  
endmodule
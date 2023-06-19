
`timescale 1ns/1ns

module mux_2to1_8bit (
  input [7:0] a,
  input [7:0] b,
  input sel,
  output [7:0] out
);
  wire [7:0] sel1, sel2;
  not (notsel, sel);
  and a1[7:0] (sel1, a, notsel);
  and a2[7:0] (sel2, b, sel);
  or r1[7:0] (out, sel1, sel2);

endmodule

module mux_2to1_4bit (
  input [3:0] a,
  input [3:0] b,
  input sel,
  output [3:0] out
);
  wire [3:0] sel1, sel2;
  not (notsel, sel);
  and a1[3:0] (sel1, a, notsel);
  and a2[3:0] (sel2, b, sel);
  or r1[3:0] (out, sel1, sel2);

endmodule

module mux_2to1_7bit (
  input [6:0] a,
  input [6:0] b,
  input sel,
  output [6:0] out
);
  wire [6:0] sel1, sel2;
  not (notsel, sel);
  and a1[6:0] (sel1, a, notsel);
  and a2[6:0] (sel2, b, sel);
  or r1[6:0] (out, sel1, sel2);

endmodule

module mux_4to1_8bit (
  input [7:0] a,
  input [7:0] b,
  input [7:0] c,
  input [7:0] d,
  input [1:0] sel,
  output [7:0] out
);
  wire [7:0] out1,out2;
  mux_2to1_8bit m1 (a, b, sel[0],out1);
  mux_2to1_8bit m2 (c, d, sel[0],out2);
  mux_2to1_8bit m3 (out1, out2, sel[1], out);
endmodule

module mux_8to1_8bit (
  input [7:0] a,
  input [7:0] b,
  input [7:0] c,
  input [7:0] d,
  input [7:0] e,
  input [7:0] f,
  input [7:0] g,
  input [7:0] h,
  input [2:0] sel,
  output [7:0] out
);
  wire [7:0] out1,out2;
  mux_4to1_8bit m1 (a, b, c, d, sel[1:0],out1);
  mux_4to1_8bit m2 (e, f, g, h, sel[1:0],out2);
  mux_2to1_8bit m3 (out1, out2, sel[2], out);
endmodule

module BarrelShift (output [7:0] Ans, input [7:0] X, input [2:0] sel);
  wire [7:0] out1,out2,out3,out4,out5,out6,out7;
  buf b1[6:0] (out1[6:0], X[7:1]);
  buf b2[5:0] (out2[5:0], X[7:2]);
  buf b3[4:0] (out3[4:0], X[7:3]);
  buf b4[3:0] (out4[3:0], X[7:4]);
  buf b5[2:0] (out5[2:0], X[7:5]);
  buf b6[1:0] (out6[1:0], X[7:6]);
  buf b7 (out7[0], X[7]);

  buf b8 (out1[7], 1'b0);
  buf b9 [1:0] (out2[7:6], 1'b0);
  buf b10[2:0] (out3[7:5], 1'b0);
  buf b11[3:0] (out4[7:4], 1'b0);
  buf b12[4:0] (out5[7:3], 1'b0);
  buf b13[5:0] (out6[7:2], 1'b0);
  buf b14[6:0] (out7[7:1], 1'b0);

  mux_8to1_8bit m (X, out1, out2, out3, out4, out5, out6, out7, sel, Ans);

endmodule

module mux_2to1_1bit (
  input a,
  input b,
  input sel,
  output out
);
  wire sel1, sel2;
  not (notsel, sel);
  and a1 (sel1, a, notsel);
  and a2 (sel2, b, sel);
  or r1 (out, sel1, sel2);

endmodule
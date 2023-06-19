`timescale 1ns/1ps
module dflipflop (
    output reg Q,
    input wire D,
    input wire clk
);

always @(posedge clk )
begin
    Q <= D;
end

always @(negedge clk)
begin
    Q <= Q;
end

endmodule



module register(output [11:0] out, input clock, input we, input [11:0] in);
  wire mid;
  and a1 (mid,clock,we);
  dflipflop d [11:0] (out,in,mid);
endmodule

module register_file(
  output[11:0] data1, output [11:0] data2,
  input[11:0] data_in,
  input [2:0] addressr1, input [2:0] addressr2, input [2:0] addressw,
  input we,input clock);

  wire [7:0][11:0] data_out;
  wire [7:0] wes;
  
  
  wire [7:0] decoded_address;
  decoder3_8 d1(decoded_address, addressw);
  //decoder3_8 d2(decoded_address2, addressr2);
  and a1[7:0] (wes,decoded_address, we);

  //read port start
  mux_8to1_12bit m1(data_out, addressr1, data1);
  mux_8to1_12bit m2(data_out, addressr2, data2);
  //read port end

  register r_f [7:0] (data_out, clock, wes, data_in);
endmodule

module decoder3_8(output [7:0] out,input[2:0] in);
  wire [2:0] nin;
  not n1[2:0](nin, in);
  and(out[7], in[0], in[1], in[2]);
  and(out[6], in[0], in[1], nin[2]);
  and(out[5], in[0], nin[1], in[2]);
  and(out[4], in[0], nin[1], nin[2]);
  and(out[3], nin[0], in[1], in[2]);
  and(out[2], nin[0], in[1], nin[2]);
  and(out[1], nin[0], nin[1], in[2]);
  and(out[0], nin[0], nin[1], nin[2]);
endmodule

module mux_2to1_12bit (
  input [1:0][11:0] a,
  input sel,
  output [11:0] out
);
  wire [11:0] sel1, sel2;
  not (notsel, sel);
  and a1[11:0] (sel1, a[0], notsel);
  and a2[11:0] (sel2, a[1], sel);
  or r1[11:0] (out, sel1, sel2);

endmodule

module mux_4to1_12bit (
  input [3:0][11:0] a,
  input [1:0] sel,
  output [11:0] out
);
  wire [1:0][11:0] mid;
  mux_2to1_12bit m1 (a[1:0], sel[0],mid[0]);
  mux_2to1_12bit m2 (a[3:2], sel[0],mid[1]);
  mux_2to1_12bit m3 (mid, sel[1], out);
endmodule

module mux_8to1_12bit (
  input [7:0][11:0] a,
  input [2:0] sel,
  output [11:0] out
);
  wire [1:0][11:0] mid;
  mux_4to1_12bit m1 (a[3:0], sel[1:0],mid[0]);
  mux_4to1_12bit m2 (a[7:4], sel[1:0],mid[1]);
  mux_2to1_12bit m3 (mid, sel[2], out);
endmodule


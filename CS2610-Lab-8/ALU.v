// `timescale 1ns/1ns

module ALUinterface(output[11:0] out, input[26:0] inputt);
    wire[11:0] A;
    wire[11:0] B;
    wire[2:0] opcode;

  buf b3[2:0](opcode, inputt[26:24]);
    buf b1[11:0] (A, inputt[23:12]);
    buf b2[11:0] (B, inputt[11:0]);

  ALUcircuit ALUc1 (out, opcode, A, B);

endmodule

module ALUinterface_memory(input clock,input [2:0] opcode, input [2:0] addressr1, input [2:0] addressr2, input [2:0] addressw);
  wire [11:0] data1;
  wire [11:0] data2;
  wire [11:0] data_in;
  register_file r1(data1,data2,data_in,addressr1,addressr2,addressw,1'b1,clock);
  wire [26:0] instruction;
  buf b1[2:0](instruction[26:24],opcode);
  buf b2[11:0](instruction[23:12],data1);
  buf b3[11:0](instruction[11:0],data2);
  ALUinterface ai(data_in,instruction);
endmodule

module ALUcircuit(output[11:0] outputt, input[2:0] opcode, input[11:0] A, input[11:0] B);
  wire [7:0][11:0] outputarr;
  buf b1[11:0] (outputarr[0],1'b0);
  
  CLA8 add8bit (outputarr[1][7:0], Cout, A[7:0], B[7:0], 1'b0);
  buf b2[11:8] (outputarr[1][11:8], 1'b0);
  
  CLAS8 sub8bit (outputarr[2][7:0], Cout, A[7:0], B[7:0]);
  buf b3[11:8] (outputarr[2][11:8], 1'b0);

  MUu MyMUu (outputarr[3][7:0], OF1, A[7:0], B[7:0]);
  buf b4[11:8] (outputarr[3][11:8], 1'b0);

  MUs MyMUs (outputarr[4][7:0], OF2, A[7:0], B[7:0]);
  buf b5[11:8] (outputarr[4][11:8], 1'b0);

  FPA MyFPA (outputarr[5][11:0], A, B);

  FPM MyFPM (OF3, outputarr[6][11:0], A, B);

  Compa cc (outputarr[7][7:0], A[7:0], B[7:0]);
  buf b6[11:8] (outputarr[7][11:8], 1'b0);

  mux_8to1_12bit Mux8to1b12 (outputarr, opcode, outputt);
endmodule
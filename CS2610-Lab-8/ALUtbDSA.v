// `timescale 1ns/100ps

// module ALU_tb();

//     reg[2:0] opcode;
// 	reg[11:0] A,B;
//     wire[11:0] result;

//   wire[26:0] instruction;
  
//   buf b3[2:0](instruction[26:24], opcode);
//   buf b1[11:0] (instruction[23:12], A);
//   buf b2[11:0] (instruction[11:0], B);
  
//   ALUinterface F (result, instruction);
	
// 	initial begin
		
//         $dumpfile("ALU_tb.vcd");
// 		$dumpvars(0, ALU_tb);

//         //Case 1: Addition
//         opcode = 001;
//         A = 12'b000011011111;
//         B = 12'b000010110110;

//         #20
//         $display("A = %b, B = %b\n     result = %b", A, B, result);
//         $display("Ans should be 000010010101\n");

//         //Case 2: Subtraction
//         opcode = 010;
//         A = 12'b000011011111;
//         B = 12'b000010110110;
//         #20
//         $display("A = %b, B = %b\n     result = %b", A, B, result);
//         $display("Ans should be 000000101001\n"); 

//         //Case 3: Unsigned Multiplication
//         opcode = 011;
//         A = 12'b000000000111;
//         B = 12'b000000000101;
//         #20
//         $display("A = %b, B = %b\n     result = %b", A, B, result);
//         $display("Ans should be 000000100011\n");

//         //Case 4: Signed Multiplication
//         opcode = 100;
//         A = 12'b000000000111;
//         B = 12'b111111111011;
//         #20
//         $display("A = %b, B = %b\n     result = %b", A, B, result);
//         $display("Ans should be 000011011101\n");

//         //Case 5: Floating Point Addition
//         opcode = 101;
//         A = 12'b010011000000;
//         B = 12'b010001000000;
//         #20
//         $display("A = %b, B = %b\n     result = %b", A, B, result);
//         $display("Ans should be 010100010000\n");

//         //Case 6: Floating Point Multiplication
//         opcode = 110;
//         A = 12'b000101100000;
//         B = 12'b110011000000;
//         #20
//         $display("A = %b, B = %b\n     result = %b", A, B, result);
//         $display("Ans should be 101010101000\n"); 

//         //Case 7: Comparator
//         opcode = 111;
//         A = 12'b000101100000;
//         B = 12'b000101100000;
//         #20
//         $display("A = %b, B = %b\n     result = %b", A, B, result);
//         $display("Ans should be 000000000000\n");
		
// 	end

// endmodule

module CPU_tb();

	reg[11:0] instruction;
  reg clk;

  wire [2:0] opcode,addr1,addr2,addr3;
  
  buf bb1[2:0](opcode, instruction[11:9]);
  buf bb2[2:0](addr1, instruction[8:6]);
  buf bb3[2:0](addr2, instruction[5:3]);
  buf bb4[2:0](addr3, instruction[2:0]);
  ALUinterface_memory ALUU(clk, opcode, addr1, addr2, addr3);
	
	initial begin
		//ADD R2,R0,R1
    clk=0;
		instruction = 12'b001010000001;
		$dumpfile("CPU_tb.vcd");
		$dumpvars(0,CPU_tb);
		
		#20
    clk=1;
    #20
		//SUB R3,R0,R1
    clk=0;
		instruction = 12'b010011000001;
		
		#20
    clk=1;
    #20
		//MUL R4,R0,R1
    clk=0;
		instruction = 12'b011100000001;
		
		#20
    clk=1;
    #20
		//IMUL R4,R0,R1
    clk=0;
		instruction = 12'b100100000001;
		
		#20
    clk=1;
    #20
		//FADD R7,R5,R6
    clk=0;
		instruction = 12'b101111101110;
		
		#20
		//FMUL R7,R5,R6
		instruction = 12'b110111101110;
		
		#20
    clk=1;
    #20
		//CMP R2,R1,R0
    clk=0;
		instruction = 12'b111010001000;
		
		#20
    clk=1;
    #20
		$finish;
	end
endmodule

// `timescale 1ns/1ns

// module Register_tb();
//     reg clk;
//     reg we;
//     reg [2:0] read1Addr;
//     reg [2:0] read2Addr;
//     reg [2:0] writeAddr;
//     reg [11:0] writeData;
//     wire [11:0] readData1;
//     wire [11:0] readData2;
//   register_file r(readData1, readData2, writeData, read1Addr, read2Addr, writeAddr, we, clk);

//     initial begin
        
//         $dumpfile("Register_tb.vcd");
//         $dumpvars(0, Register_tb);

//         clk = 0;
//         we = 1;
//         read1Addr = 0;
//         read2Addr = 1;
//         writeAddr = 2;
//         writeData = 2;

//         #20

//         clk = 1;

//         #20

//         clk = 0;
//         we = 1;
//         read1Addr = 2;
//         read2Addr = 1;
//         writeAddr = 0;
//         writeData = 0;

//         #20

//         clk = 1;

//         #20

//         clk = 0;
//         we = 1;
//         read1Addr = 0;
//         read2Addr = 2;
//         writeAddr = 1;
//         writeData = 1;

//         #20

//         clk = 1;

//         #20

//         $finish;
//     end

// endmodule
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:15:50 02/11/2016 
// Design Name: 
// Module Name:    StopwatchTester 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module StopwatchTester;

	reg clk;
	reg sw6;
	reg sw7;
	reg btnReset;
	reg btnPause;
		
	always #5 clk = ~clk;

	wire [6:0] seg;
	wire [3:0] an;

	Stopwatch sw(
	    .sw6(sw6), //SELECT
		.sw7(sw7), //ADJUST
		.btnR(btnReset), //reset
		.btnS(btnPause), //pause
		.clk(clk),
		.seg(seg),
		.an(an)
	);
	
	initial
		begin
			clk = 0;
			sw6 = 0;
			sw7 = 0;
			btnReset = 0;
			btnPause = 0;
			#1100000000;
			btnReset = 1;
			#1000000
			btnReset = 0;
			#990000000;
			$finish;
		end
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:15:38 02/04/2016 
// Design Name: 
// Module Name:    ClockTest 
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
module ClockTest(
    output CLOCK
    );

	reg clk;
	wire one;
	wire two;
	wire fast;
	wire adj;
	
	initial
		begin
			clk = 0;
		end
		
	always #5 clk = ~clk;
	assign CLOCK = clk;
	
	ClockDivider CD(
    .M_CLK(CLOCK),
    .ONE_CLK(one),
    .TWO_CLK(two),
    .FAST_CLK(fast),
    .ADJ_CLK(adj)
    );

endmodule

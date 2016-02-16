`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:15:14 02/02/2016 
// Design Name: 
// Module Name:    ClockDivider 
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
module ClockDivider(
    input M_CLK,
    output ONE_CLK,
    output TWO_CLK,
    output FAST_CLK,
    output ADJ_CLK
    );

	reg[26:0] 	one_counter;	//1hz
	reg[25:0]	two_counter;	//2hz
	reg[17:0]	fast_counter;	//625hz
	reg[24:0]	adj_counter;	//5hz
	reg one_clk;
	reg two_clk;
	reg fast_clk;
	reg adj_clk;
	
	assign ONE_CLK = one_clk;
	assign TWO_CLK = two_clk;
	assign FAST_CLK = fast_clk;
	assign ADJ_CLK = adj_clk;
	
	initial
		begin
			one_counter = 0;
			two_counter = 0;
			fast_counter = 0;
			adj_counter = 0;
			one_clk = 0;
			two_clk = 0;
			fast_clk = 0;
			adj_clk = 0;
		end
	
	always @ (posedge M_CLK)
		begin
			if (one_counter == 100000000)
				begin
					one_counter <= 0;
					one_clk <= 1;
				end
			else
				begin
					one_counter <= one_counter + 27'b1;
					one_clk <= 0;
				end
			if (two_counter == 50000000)
				begin
					two_counter <= 0;
					two_clk <= 1;
				end
			else
				begin
					two_counter <= two_counter + 26'b1;
					two_clk <= 0;
				end
			if (fast_counter == 160000)
				begin
					fast_counter <= 0;
					fast_clk <= 1;
				end
			else
				begin
					fast_counter <= fast_counter + 18'b1;
					fast_clk <= 0;
				end
			if (adj_counter == 20000000)
				begin
					adj_counter <= 0;
					adj_clk <= 1;
				end
			else
				begin
					adj_counter <= adj_counter + 25'b1;
					adj_clk <= 0;
				end	
		end
endmodule

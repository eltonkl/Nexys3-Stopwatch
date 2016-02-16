`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:13:52 02/02/2016 
// Design Name: 
// Module Name:    Stopwatch 
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
module Stopwatch(
    input sw6, //SELECT
    input sw7, //ADJUST
    input btnR, //reset
    input btnS, //pause
    input clk,
    output [6:0] seg,
	output [3:0] an
    );
	
	wire one_clk;
	wire two_clk;
	wire fast_clk;
	wire adj_clk;
	wire sel;
	wire adj;
	wire reset;
	wire pause;

	SwitchDebouncer sel_db(
		.clk(fast_clk),
		.switch(sw6),
		.O(sel)
	);
	SwitchDebouncer adj_db(
		.clk(fast_clk),
		.switch(sw7),
		.O(adj)
	);
	BtnDebouncer reset_db(
		.clk(fast_clk),
		.btnS(btnR),
		.O(reset)
	);
	BtnDebouncer pause_db(
		.clk(fast_clk),
		.btnS(btnS),
		.O(pause)
	);
	
	ClockDivider cd(
		.M_CLK(clk),
		.ONE_CLK(one_clk),
		.TWO_CLK(two_clk),
		.FAST_CLK(fast_clk),
		.ADJ_CLK(adj_clk)
	);
	
	wire [3:0] mt;
	wire [3:0] mo;
	wire [3:0] st;
	wire [3:0] so;
	wire adj_mode;
	
	TimeToDisplay ttd(
		.SEL(sel),
		.ADJ(adj),
		.RESET(reset),
		.PAUSE(pause),
		.ONE_CLK(one_clk),
		.TWO_CLK(two_clk),
		.ADJ_CLK(adj_clk),
		.M_CLK(clk),
		.MT(mt),
		.MO(mo),
		.ST(st),
		.SO(so),
		.ADJ_MODE(adj_mode)
	);
	
	DispTime dt(
		.FAST_CLK(fast_clk),
		.EN(adj_mode),
		.MT(mt),
		.MO(mo),
		.ST(st),
		.SO(so),
		.A(an),
		.C(seg)
	);

endmodule

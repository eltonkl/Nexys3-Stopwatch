`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:26:20 02/09/2016 
// Design Name: 
// Module Name:    TimeToDisplay 
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
module TimeToDisplay(
    input SEL,
    input ADJ,
    input ONE_CLK,
    input TWO_CLK,
    input ADJ_CLK,
	input M_CLK,
	input RESET,
    input PAUSE,
    output [3:0] MT,
    output [3:0] MO,
    output [3:0] ST,
    output [3:0] SO,
    output ADJ_MODE
    );

	parameter MINUTES = 0;
	parameter SECONDS = 1;

	reg[3:0] mt;
	reg[3:0] mo;
	reg[3:0] st;
	reg[3:0] so;
	reg adj_mode;
	
	assign MT = mt;
	assign MO = mo;
	assign ST = st;
	assign SO = so;
	assign ADJ_MODE = adj_mode;
	
	reg is_paused;
	reg do_reset;
	
	initial
		begin
			mt = 'b0000;
			mo = 'b0000;
			st = 'b0000;
			so = 'b0000;
			is_paused = 0;
			do_reset = 0;
		end
	
	always @ (posedge M_CLK)
	begin
		if (RESET == 1)
			begin
				do_reset = 1;
			end
		if (ADJ == 1 && TWO_CLK == 1)
			begin
				if (do_reset == 1)
					begin
						mt = 'b0000;
						mo = 'b0000;
						st = 'b0000;
						so = 'b0000;
						do_reset = 0;
					end
				else if (SEL == MINUTES)
					begin
						incMin();
					end
				else
					begin
						incSec();
					end
			end
		else if (ADJ == 0 && is_paused == 0 && ONE_CLK == 1)
			begin
				if (do_reset == 1)
					begin
						mt = 'b0000;
						mo = 'b0000;
						st = 'b0000;
						so = 'b0000;
						do_reset = 0;
					end
				else
					begin
						incSec();
					end
			end
	end
	
	always @ (posedge ADJ_CLK)
		if (ADJ == 1)
			begin
				adj_mode = ~adj_mode;
			end
		else
			begin
				adj_mode = 1;
			end
	
	always @ (PAUSE)
		if (PAUSE == 1)
			begin
				is_paused <= ~is_paused;
			end
		
	task incMin;
		begin
			if (mo + 4'b0001 >= 10)
				begin
					mo = 0;
					if (mt + 4'b0001 >= 10)
						begin
							mt = 4'b0000;
						end
					else
						begin
							mt = mt + 4'b0001;
						end
				end
			else
				begin
					mo = mo + 4'b0001;
				end
		end
	endtask
	
	task incSec;
		begin
			if (so + 4'b0001 >= 10)
				begin
					so = 0;
					if (st + 4'b0001 >= 6)
						begin
							st = 0;
							incMin();
						end
					else
						begin
							st = st + 4'b0001;
						end
				end
			else
				begin
					so = so + 4'b0001;
				end
		end
	endtask
	
endmodule

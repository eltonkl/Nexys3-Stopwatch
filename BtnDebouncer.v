`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:08:08 02/09/2016 
// Design Name: 
// Module Name:    Debouncer 
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
module BtnDebouncer(
    input btnS,
	input clk,
    output O
    );

	reg[2:0] 	step_d;
	reg			clk_en_d;
	reg			o;
	
	assign O = o;
	
	initial
		begin
			step_d = 0;
			clk_en_d = 0;
			o = 0;
		end
	
	always @ (posedge clk)
		begin
			clk_en_d <= clk;
		end
	
	always @ (posedge clk)
		begin
			step_d[2:0]  <= {btnS, step_d[2:1]};
        end
			
    always @ (posedge clk)
		begin
			o <= ~step_d[0] & step_d[1] & clk_en_d;
		end
endmodule

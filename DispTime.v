`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:46:39 02/04/2016 
// Design Name: 
// Module Name:    DispTime 
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
module DispTime(
    input FAST_CLK,
    input EN,
    input [3:0] MT,
    input [3:0] MO,
	input [3:0] ST,
	input [3:0] SO,
    output [3:0] A,
    output [6:0] C
    );

	reg[1:0] digitIndex;
	reg[3:0] a;
	reg[6:0] c;

	assign A = a;
	assign C = c;
	
	initial
		begin
			digitIndex = 0;
			a = 'b0001;
			c = 'b0000000;
		end

	always @ (posedge FAST_CLK)
		begin
			if (digitIndex == 0)
				begin
					digitIndex <= 3;
				end
			else
				begin
					digitIndex <= digitIndex - 2'b1;
				end
			case(digitIndex)
				3:
					begin
						bin2seg(MT, c);
						a = 'b0111;
					end
				2:
					begin
						bin2seg(MO, c);
						a = 'b1011;
					end
				1:
					begin
						bin2seg(ST, c);
						a = 'b1101;
					end
				default:
					begin
						bin2seg(SO, c);
						a = 'b1110;
					end
			endcase
		end

	task bin2seg;
		input [3:0] number;
		output [6:0] segment;
		begin
			if (EN == 1)
				begin
					case(number)
						1: segment = 'b1111001;
						2: segment = 'b0100100;
						3: segment = 'b0110000;
						4: segment = 'b0011001;
						5: segment = 'b0010010;
						6: segment = 'b0000010;
						7: segment = 'b1111000;
						8: segment = 'b0000000;
						9: segment = 'b0010000;
						default: segment = 'b1000000;
					endcase
				end
			else
				begin
					segment = 'b1111111;
				end
		end
	endtask

endmodule

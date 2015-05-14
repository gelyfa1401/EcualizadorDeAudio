`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:59:45 04/29/2015 
// Design Name: 
// Module Name:    RegOpe 
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
module RegOpe #(parameter N = 23)(

		input wire clk,rst, 
		input wire [N-1:0] entrada, 
		output reg [N-1:0] salida 
    );
	 


always@(posedge clk, posedge rst)

	if(rst)
		salida <= 0; 
	else
		salida <= entrada; 
		
endmodule

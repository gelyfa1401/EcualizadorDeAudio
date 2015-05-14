`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:51:39 04/21/2015 
// Design Name: 
// Module Name:    MUX 
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
module MUX #(parameter N=25)(
    input wire [1:0] sel,
	 input wire signed [N-1:0] hf,mf,lf,
	 output wire signed [N-1:0] salida1
 );

reg signed [N-1:0] salida;

always @(sel,hf,mf,lf)

  case(sel)
		2'b00: salida = hf;
		2'b01: salida = mf;
		2'b10: salida = lf;
		default: salida = 0;
   endcase
	
assign salida1 = salida;	
 
endmodule

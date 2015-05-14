`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:26:38 04/29/2015 
// Design Name: 
// Module Name:    Adju_1 
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
module Adju_1(
	input wire [11:0] salidaADC,
	output wire signed [22:0] entradafiltro
    );

reg [22:0] paquete;

always @*
	begin
		paquete = {9'b000000000,salidaADC,2'b00}; // 8 de magnitud + 1 de signo= 9 bits en 0, 2 bits en 00 para completar los 23
	end

Sumador #(.N(23)) Sumaaa (
	.DataA(paquete),
	.DataB(23'b11111111110000000000000),
	.Suma(entradafiltro)
);

endmodule

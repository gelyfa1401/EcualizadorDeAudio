`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:59:50 04/29/2015 
// Design Name: 
// Module Name:    Adju_2 
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
module Adju_2(
	input wire signed [22:0] salidafiltro,
	output wire [11:0] entradaDAC
    );

wire signed [22:0] salidafiltro2;
reg [11:0] entradaDAC1;

Sumador #(.N(23)) Sumaaa (
	.DataA(salidafiltro),
	.DataB(23'b00000000010000000000000),
	.Suma(salidafiltro2)
);

always @*
	begin
		entradaDAC1 = salidafiltro2 [13:2]; // 13:2 para extraer sólo la parte decimal
	end

assign entradaDAC = entradaDAC1;

endmodule

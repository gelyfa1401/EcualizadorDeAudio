`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:44:06 04/26/2015 
// Design Name: 
// Module Name:    Pasa_Banda_5ka20k 
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
module Pasa_Banda_5ka20k #(parameter  decim=14, magn=8, N = decim+magn+1)(    //20Hz a 200Hz

input clock, gen_enable, reset,
input wire signed [N-1:0] DataIn,
output wire signed [N-1:0] DataOut

    );

wire signed [N-1:0] salida1;


// agregar - a a1 y a2

//a1 = 65D2
//a2 = 2A59
//b0 = 340B
//b1 = 6810
//b2 = 340B

Filtro #(.N(N)) Pasa_Altas20k (
	.clock (clock), 
	.gen_enable (gen_enable),
	.reset (reset),
	.b0(23'h00340B),
	.a1(-(23'h0065D2)),
	.b1(23'h006810),
	.a2(-(23'h002A59)),
	.b2(23'h00340B),
	.DataU(DataIn),  //
	.DataY(salida1)  //
);


//a1 = 7FBDC2
//a2 = 178A
//b0 = 552
//b1 = AA4
//b2 = 552

Filtro #(.N(N)) Pasa_Bajo5k (
	.clock (clock), 
	.gen_enable (gen_enable),
	.reset (reset),
	.b0(23'h000552),
	.a1(-(23'h7FBDC2)),
	.b1(23'h000AA4),
	.a2(-(23'h00178A)),
	.b2(23'h000552),
	.DataU(salida1),
	.DataY(DataOut)
);



endmodule


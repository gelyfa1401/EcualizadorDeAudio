`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:43:34 04/26/2015 
// Design Name: 
// Module Name:    Pasa_Banda_200a5000 
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
module Pasa_Banda_200a5k #(parameter  decim=14, magn=8, N = decim+magn+1)(   

input clock, gen_enable, reset,
input wire signed [N-1:0] DataIn,
output wire signed [N-1:0] DataOut

    );

wire signed [N-1:0] salida1;


// agregar - a a1 y a2


//a1 = 7FBDC2
//a2 = 178A
//b0 = 552
//b1 = AA4
//b2 = 552


Filtro #(.N(N)) Pasa_Altas5k (
	.clock (clock), 
	.gen_enable (gen_enable),
	.reset (reset),
	.b0(23'h000552),
	.a1(-(23'h7FBDC2)),
	.b1(23'h000AA4),
	.a2(-(23'h00178A)),
	.b2(23'h000552),
	.DataU(DataIn),  //
	.DataY(salida1)  //
);



//a1 = 7F828F
//a2 = 3D78
//b0 = 000003
//b1 = 000006
//b2 = 000003


Filtro #(.N(N)) Pasa_Bajo200 (
	.clock (clock), 
	.gen_enable (gen_enable),
	.reset (reset),
	.b0(23'h000003),
	.a1(-(23'h7F828F)),
	.b1(23'h000006),
	.a2(-(23'h003D78)),
	.b2(23'h000003),
	.DataU(salida1),
	.DataY(DataOut)
);



endmodule

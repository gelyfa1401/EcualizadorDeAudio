`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:39:59 04/29/2015 
// Design Name: 
// Module Name:    DAC_General 
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
module DAC_General(
	input wire Rst,Clk,
	input wire [11:0] Data_In,
	input wire Rx_Listo, 
	output wire Sync,
	output wire Data_Out
	);
	

//Cables necesarios para la unión
wire Clk_Capt;

//Instanciación del módulo receptor y el divisor de frecuencia

DAC_Recep DACrecep (
	.Clk_Captura(Clk_Capt),
	.Rst(Rst),
	.Clk(Clk),
	.Data_In(Data_In),
	.Rx_Listo(Rx_Listo), 
	.Sync(Sync),
	.Data_Out(Data_Out)
);

Divisor_Frec Divisor (
	.clk_in(Clk),
	.clk_rst(Rst),
	.clk_out(Clk_Capt)
);

endmodule

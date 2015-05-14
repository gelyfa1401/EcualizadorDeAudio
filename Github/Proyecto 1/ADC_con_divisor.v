`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:12:48 04/11/2015 
// Design Name: 
// Module Name:    ADC_con_divisor 
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
module ADC_con_divisor(

	input wire clk,rst,inicio_rx, dato,
	output wire CS,
	output wire rx_listo,
	output wire [11:0] paquete_bits,
	output wire [3:0] bits_zero
	
    );
	 
wire clk_out;

Divisor_Frec divisor (
    .clk_in(clk), 
    .clk_rst(rst), 
    .clk_out(clk_out)
    );

ADC_Recep recepcion (
    .clk_captura(clk_out), 
    .rst(rst), 
    .inicio_rx(inicio_rx), 
    .dato(dato), 
    .CS(CS), 
    .rx_listo(rx_listo), 
    .paquete_bits(paquete_bits), 
    .bits_zero(bits_zero)
    );


endmodule

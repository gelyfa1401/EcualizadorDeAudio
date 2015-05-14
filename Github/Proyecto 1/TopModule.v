`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:51:05 04/29/2015 
// Design Name: 
// Module Name:    TopModule 
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
module TopModule #(parameter  decim=14, magn=8, N = decim+magn+1)(

	input wire clk, rst, rst_clk, ini_rx, datoADC,
	input wire[1:0] selector,
	output wire cs,datoDAC,sync,clkdiv,clk2,
	output wire [3:0] bitwarning
    );

wire listo;
wire signed [N-1:0] entradafilt, out_b1,out_m1,out_a1,salidaMUX; 
wire [11:0] paq_bits,entDAC;
assign clk2 = clkdiv;
 
Divisor_Frec divisor(
    .clk_in(clk), 
    .clk_rst(rst_clk), 
    .clk_out(clkdiv)
    );

ADC_con_divisor ADC (
    .clk(clk), 
    .rst(rst), 
    .inicio_rx(ini_rx), 
    .dato(datoADC), 
    .CS(cs), 
    .rx_listo(listo), 
    .paquete_bits(paq_bits), 
    .bits_zero(bitwarning)
    );

Adju_1 ajuste1(
    .salidaADC(paq_bits), 
    .entradafiltro(entradafilt)
    );


Filtrado #(.decim(decim),.magn(magn)) filtrado (  
    .clock(clk), 
    .reset(rst), 
    .gen_enable(listo), 
    .dato_entrada(entradafilt), 
    .out_b(out_b1), 
    .out_m(out_m1), 
    .out_a(out_a1)
    );
	 
MUX # (.N(N)) Mux (
    .sel(selector), 
    .hf(out_a1), 
    .mf(out_m1), 
    .lf(out_b1), 
    .salida1(salidaMUX)
    ); 
	 
Adju_2 ajuste2 (
    .salidafiltro(salidaMUX), 
    .entradaDAC(entDAC)
    );

DAC_General d (
    .Rst(rst), 
    .Clk(clk), 
    .Data_In(entDAC), 
    .Rx_Listo(ini_rx), 
    .Sync(sync), 
    .Data_Out(datoDAC)
    );

 
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:44:08 04/19/2015 
// Design Name: 
// Module Name:    Registro_Pipeline 
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
module Registro_Pipeline#(parameter N = 8)
	(
		input wire clk, reset, enable, 
		input wire [N-1:0] dato_entrada, 
		output wire [N-1:0] salida 
    );
	 
reg [N-1:0] estado_actual ,estado_sgte; // Estados del registro.
                                

always@(posedge clk, posedge reset)

	if(reset)
		estado_actual <= 0; // Cuando la señal de reset está activa, el estado actual es igual a cero.
	else
		estado_actual <= estado_sgte; // Se actualiza el estado. 
		

always@*

   begin
	estado_sgte = estado_actual;
	
	if(~enable) 
	   estado_sgte =  dato_entrada; // Se carga el dato de entrada.
	else 
	   estado_sgte = estado_actual; // Se mantiene igual el dato de salida.
	end 
	
assign salida = estado_actual ; // Se le asigna la a la salida el valor actual.

endmodule

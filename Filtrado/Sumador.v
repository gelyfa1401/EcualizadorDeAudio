`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:36:38 04/13/2015 
// Design Name: 
// Module Name:    Sumador 
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
module Sumador #(parameter N=23)(

input wire signed[N-1:0] DataA, DataB,
output reg signed[N-1:0] Suma

    );

//Variable auxiliar, para guardar el resultado de la suma momentaneamente, 
//antes de verificar si se presenta underflow u overflow.
//Variables de saturación máxima y mínima para el resultado de la suma,
//definición de los valores de saturación para underflow y overflow

reg signed [N-1:0] SumaParcial; 
reg [N-1:0] SatMax, SatMin;
reg [N:0] max, min;


//Se define la suma, así como los valores máximos y mínimos de saturación
always @*
begin
	SumaParcial = DataA + DataB;
	max = (2**(N-1)-1);
	min = (2**(N-1)+1);
	SatMax = max[N-1:0];
	SatMin = min[N-1:0];
end

//Resultado de la suma para cada caso de saturación
always @*
begin
	if (DataA[N-1] == 0 && DataB[N-1] == 0 && SumaParcial[N-1] == 1)//operandos positivos, resultado de suma negativo
		begin
			Suma = SatMax;
		end
		
	else if (DataA[N-1] == 1 && DataB[N-1] == 1 && SumaParcial[N-1] == 0)//operandos negativos, resultado de suma positivo
		begin
			Suma = SatMin;
		end
			
	else 
		Suma = SumaParcial;
end

endmodule

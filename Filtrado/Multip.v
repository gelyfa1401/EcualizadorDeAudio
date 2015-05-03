`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:05:21 04/25/2015 
// Design Name: 
// Module Name:    Multip 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created  (parameter N=8, Dec=2, Entero=N-Dec-1
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Multiplicacion #(parameter  decim=16, magn=8, N = decim+magn+1) (

	input signed [N-1:0] A,B,
	output reg signed[N-1:0]ResulMult
	
    );
	 
reg signed [2*N-1:0] Aux; // Variable que almacena el resultado temporal de la multiplicación.
reg overflow, underflow; 
 
localparam [N:0] 
				SatMax = (2**(N-1)-1),   // Se define la saturación máxima para el caso de overflow.
				SatMin = (2**(N-1)+1);   // Se define la saturación máxima para el caso de underflow.

always @*
	begin
		Aux =A*B;
		//
		if ((A[N-2:0] == 0) || (B[N-2:0] == 0))  // Caso para cuando se multiplica por 0.
			ResulMult = 0;
			
		else
			begin
			   // Caso para cuando los operandos tienen el mismo signo. 
				if ((A[N-1] == B[N-1]) && ((Aux[2*N-1:(magn+decim+decim)] > 0))) // Hay overflow si el numero binario que está entre el bit más significativo y la primera magnitud es mayor a cero.
					ResulMult = SatMax;
					
				 // Caso para cuando los operandos tienen diferente signo. 	
				else if  ((A[N-1] != B[N-1]) && (~(&(Aux[2*N-1:(magn+decim+decim)])) == 1'b1)) // Para detectar underflow "se analiza con una nand" para detectar unos.
					ResulMult = SatMin;
					
				// Se trunca el resultado en caso de que no haya overflow o underflow, tomando de la parte decimal a la primera magnitud.	
				else	
					ResulMult = Aux[2*N-2-magn:decim];
			    
			end
	end
	
endmodule


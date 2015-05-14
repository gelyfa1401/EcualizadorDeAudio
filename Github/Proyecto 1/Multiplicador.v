`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:58:30 04/13/2015 
// Design Name: 
// Module Name:    Multiplicador 
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
module Multip #(parameter N=23, sign=1, decim=14, magn=N-decim-sign) (

	input signed [N-1:0] A,B,
	output reg signed[N-1:0]ResulMult
	
    );
	 
reg signed[2*N-1:0]Aux;
reg overflow, underflow;	
 
localparam [N:0] 
				SatMax = (2**(N-1)-1),
				SatMin = (2**(N-1)+1);

always @*
	begin
		Aux =A*B;
		
		if ((A[N-2:0] == 0) || (B[N-2:0] == 0))
			ResulMult = 0;
			
		else
			begin
				if ((A[N-1] == B[N-1]) && ((Aux[2*N-1:(magn+decim+decim)] > 0)))
					ResulMult = SatMax;
					
				else if  ((A[N-1] != B[N-1]) && (~(&(Aux[2*N-1:(magn+decim+decim)])) == 1'b1))	
					ResulMult = SatMin;
					
				else	
					ResulMult = Aux[2*N-2-magn:decim];
			    
			end
	end
	
endmodule


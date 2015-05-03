`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:24:13 04/28/2015 
// Design Name: 
// Module Name:    DAC_Recep 
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
module DAC_Recep(
	input wire Clk_Captura,Rst,Clk,
	input wire [11:0] Data_In,
	input wire Rx_Listo, 
	output wire Sync,
	output wire Data_Out
    );

//Se definen los estados de la FSM a utilizar 

localparam [1:0]
		Inicio = 2'b00,
		Envio = 2'b01,
		Listo = 2'b10;

//variables necesarias para el funcionanmiento de la FSM

reg Data_Actual,Data_Next;
reg [3:0] Bit_Actual,Bit_Next;
reg Sync_Actual,Sync_Next;
reg [1:0] Est_Actual,Est_Next;
reg [3:0] Cont_Actual,Cont_Next;
reg D_Listo;
reg [1:0] Val_Actual;
wire [1:0] Val_Next;
reg Clk_DActual;
wire Clk_DNext;

//Detector de flancos

always @(posedge Clk, posedge Rst)

  if (Rst)
     begin 
	      Val_Actual <= 0;
			Clk_DActual <= 0;
	  end 
	  
  else 
     begin 
	      Val_Actual <= Val_Next;
			Clk_DActual <= Clk_DNext;
	  end 
	
	assign Val_Next =  {Clk_Captura,Val_Actual[1]};
   assign Clk_DNext =  (Val_Actual==2'b11) ? 1'b1:
		                 (Val_Actual==2'b00) ? 1'b0:
								  Clk_DActual;
								  
	assign fall_edge = Clk_DActual & ~ Clk_DNext; 

//Estructura para definición de Estado Actual-Siguiente
always@(negedge Clk, posedge Rst)
       begin 
		      if(Rst)
				   begin
				   Data_Actual <= 0;
               Sync_Actual <= 1;
					Est_Actual <= 0;
					Cont_Actual <= 0;
					Bit_Actual <= 0;
				   end
					
            else 
				   begin 
				   Data_Actual <= Data_Next;
					Sync_Actual <= Sync_Next;
					Est_Actual <= Est_Next;
					Cont_Actual <= Cont_Next;
					Bit_Actual <= Bit_Next;
					end 
			end 
			
//Estructura para definición de Estados Siguientes, se utilizan dos contadores para recorrer 
//los paquetes de datos que ingresan, uno cuenta hacia arriba y el otro hacia abajo, a partir de esto, 
//los datos entrantes en paralelo, salen del modulo en serie, listos para ingresar al Pmod

always @*
      begin 
		Data_Next = Data_Actual;
		Sync_Next =Sync_Actual;
		Est_Next = Est_Actual;
		Cont_Next = Cont_Actual;
		Bit_Next = Bit_Actual; 
		case (Est_Actual)
		      
				Inicio:   if(Rx_Listo && Sync_Next && fall_edge)
				             begin
				             Sync_Next = 1'b0;
								 Bit_Next = 4'd11; 
								 Cont_Next = 4'd0;

							    Est_Next = Envio;
							    end 
							 else 
							    Est_Next = Inicio;
								 
				Envio:   if(fall_edge)
			              begin
			               if (Cont_Next == 15)
						          begin
								    Est_Next = Listo;
                            end 
						  
						      else if (Cont_Next >= 3)
							        begin 
							        Data_Next = Data_In [Bit_Next] ;
							        Bit_Next = Bit_Next - 1'b1 ;
							        Cont_Next = Cont_Next + 1'b1 ;
							        end
									  
							    else 
							        begin 
								     Data_Next = 1'b0;
								     Cont_Next = Cont_Next + 1'b1;
								     end 
								end 
				Listo:
			            begin
						   Data_Next = 1'b0;
							Sync_Next = 1'b1;
							Est_Next = Rx_Listo;
							end 
							
			default: 	Est_Next = Rx_Listo;
			
			endcase
			end 


//Definicion de salidas para la FSM
assign Sync = Sync_Actual;
assign Data_Out= Data_Actual;

endmodule


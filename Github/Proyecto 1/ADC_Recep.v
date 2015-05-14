`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    
// Design Name: 
// Module Name:    
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

module ADC_Recep(

	input wire clk_captura, rst,inicio_rx, dato,
	output wire CS,
	output reg rx_listo,
	output wire [11:0] paquete_bits,
	output wire [3:0] bits_zero

);
 

localparam [1:0]

  s0=2'b00,
  s1=2'b01,
  s2=2'b10;
					 
// Definición de las variables de la máquina.
					 
reg [15:0] dato_actual, dato_siguiente;   // Dato de completo 
reg [11:0] dato_final_actual, dato_final_sgte;  // Dato sin los bits del inicio (ceros)
reg [3:0]cont_act,cont_sgte; 
reg CS_act , CS_sgte;  // Selector de lectura de datos.
reg [1:0] estado_actual,estado_sgte;  // Estados de la máquina.

always@(posedge clk_captura,posedge rst)

       begin 
		 
		      if(rst)
				   begin
				   dato_actual <= 0;
               CS_act <= 1; // Cuando no está leyendo, el selector tiene que estar en 1.
					estado_actual <= 0;
					cont_act <= 0;
					dato_final_actual <=0;
				   end
					
            else 
				   begin 
				   dato_actual <= dato_siguiente;
					CS_act <= CS_sgte;
					estado_actual <= estado_sgte;
					cont_act <= cont_sgte;
					dato_final_actual <= dato_final_sgte;
					end 
			end 
			


always @*

// Definición temporal para los estados iniciales.
		
     begin 
		
		dato_siguiente = dato_actual;
		CS_sgte = CS_act;
		estado_sgte = estado_actual;
		cont_sgte = cont_act;
		dato_final_sgte = dato_final_actual;
		rx_listo = 1'b0; 
		
		case (estado_actual)
		      
				s0:   
							
							if(inicio_rx && CS_sgte)
				             begin
				             CS_sgte = 1'b0;   // Se pone CS en 0 para que inicie la recepción del protocolo.
							    estado_sgte = s1;
							    cont_sgte = 4'd0;  // Se inicializa el contador.
							    end 
							 else 
							    estado_sgte = s0;
								 
				s1:  
				
			           if(cont_sgte == 15)
						     estado_sgte = s2;   // Si el contador está en 15 ya está completo el paquete de datos.
						  else 
							  begin 
							  dato_siguiente = {dato,dato_siguiente[15:1]};  // Corrimiento - entrada en serie de los datos.
							  cont_sgte = cont_sgte + 1'b1; //Aumenta el contador.
							  end
							  
				s2 :
				
			            begin
							rx_listo = 1'b1;
							CS_sgte = 1'b1;
							//El dato debe invertirse porque el ADC saca de primero el MSB.
							dato_final_sgte[0]  = dato_siguiente[15]; 
							dato_final_sgte[1]  = dato_siguiente[14]; 
							dato_final_sgte[2]  = dato_siguiente[13];
							dato_final_sgte[3]  = dato_siguiente[12]; 
							dato_final_sgte[4]  = dato_siguiente[11]; 
							dato_final_sgte[5]  = dato_siguiente[10]; 
							dato_final_sgte[6]  = dato_siguiente[9]; 
							dato_final_sgte[7]  = dato_siguiente[8]; 
							dato_final_sgte[8]  = dato_siguiente[7]; 
							dato_final_sgte[9]  = dato_siguiente[6]; 
							dato_final_sgte[10] = dato_siguiente[5];
							dato_final_sgte[11] = dato_siguiente[4];
							estado_sgte = s0; //Regresa al estado inicial.
							end 
							
			default :   estado_sgte = s0;
			
		endcase
	  end 
	  
//Definición de las salidas del protocolo de recepción


assign CS = CS_act;
assign bits_zero = dato_actual[3:0];
assign paquete_bits = dato_final_sgte;

endmodule

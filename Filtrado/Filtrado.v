`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:51:04 04/26/2015 
// Design Name: 
// Module Name:    Filtrado 
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
module Filtrado #(parameter  decim=14, magn=8, N = decim+magn+1)(

input wire clock,reset,gen_enable,
input wire signed [N-1:0] dato_entrada,
output wire signed[N-1:0] out_b,out_m,out_a

    );
wire signed[N-1:0] o_200b, o_5kb, o_20kb;
wire clockRegPipe;

Divisor_Frec divi (
    .clk_in(clock), 
    .clk_rst(reset), 
    .clk_out(clockRegPipe)
    );
	
// agregar - a a1 y a2

//------------Filtros frecuencias bajas----------------//

Filtro #(.N(N)) b_b (         //PasoBajo 200Hz
	.clock (clock), 
	.clockRegPipe(clockRegPipe),
	.gen_enable (gen_enable),
	.reset (reset),
	.b0(23'h000003),      //3   		//0.000199
	.a1(-(23'h7F828F)),   //7F828F  	//-1.96
	.b1(23'h000006),      //6   		//0.0003979
	.a2(-(23'h003D78)),   //3D78 	 	//0.9605
	.b2(23'h000003),      //3   		//0.000199
	.DataU(dato_entrada),
	.DataY(o_200b)
);


Filtro #(.N(N)) b_a (     //PasoAlto 20Hz
	.clock (clock), 
	.clockRegPipe(clockRegPipe),
	.gen_enable (gen_enable),
	.reset (reset),
	.b0(23'h003FDF),        //3FDF      //0.998
	.a1(-(23'h7F8041)),     //7F8041		//-1.996
	.b1(23'h7F8041),        //7F8041  	//-1.996
	.a2(-(23'h003FBE)),     //3FBE		//0.996
	.b2(23'h003FDF),        //3FDF		//0.998
	.DataU(o_200b),
	.DataY(out_b)
);

//---------Filtros frecuencias medias-----------//


Filtro #(.N(N)) m_b (               //Paso Bajo 5kHz 
	.clock (clock), 
	.clockRegPipe(clockRegPipe),
	.gen_enable (gen_enable),
	.reset (reset),
	.b0(23'h000552),          //552  		//0.08316
	.a1(-(23'h7FBDC2)),       //7FBDC2		//-1.035
	.b1(23'h000AA4),          //AA4			//0.1663
	.a2(-(23'h00178A)),       //178A			//0.3678
	.b2(23'h000552),          //552			//0.08316
	.DataU(dato_entrada),
	.DataY(o_5kb)
);

Filtro #(.N(N)) m_a (        //Paso Alto 200Hz
	.clock (clock), 
	.clockRegPipe(clockRegPipe),
	.gen_enable (gen_enable),
	.reset (reset),
	.b0(23'h004000),        //4000		//1
	.a1(-(23'h7F828F)),     //7F828F		//-1.96
	.b1(23'h7F8000),        //7F8000		//-2
	.a2(-(23'h003D78)),     //3D78		//0.9605
	.b2(23'h004000),        //4000		//1
	.DataU(o_5kb),  
	.DataY(out_m)  
);

//------------Filtros frecuencias altas-----------------//

Filtro #(.N(N)) a_b (             //Paso Bajo 20KHz
	.clock (clock), 
	.clockRegPipe(clockRegPipe),
	.gen_enable (gen_enable),
	.reset (reset),
	.b0(23'h00340B),          //340B		//0.8132
	.a1(-(23'h0065D2)),       //65D2		//1.591
	.b1(23'h006810),          //6810		//1.626
	.a2(-(23'h002A59)),       //2A59		//0.6617
	.b2(23'h00340B),          //340B		//0.8132
	.DataU(dato_entrada),  
	.DataY(o_20kb)
);


Filtro #(.N(N)) a_a (            //Paso Alto 5KHz
	.clock (clock), 
	.clockRegPipe(clockRegPipe),
	.gen_enable (gen_enable),
	.reset (reset),
	.b0(23'h002671),       //2671			//0.6007
	.a1(-(23'h7FBDC2)),    //7FBDC2		//-1.035
	.b1(23'h7FB323),       //7FB323		//-1.201
	.a2(-(23'h00178A)),    //178A			//0.3678
	.b2(23'h002671),       //2671			//0.6007
	.DataU(o_20kb),  
	.DataY(out_a)  
);


endmodule

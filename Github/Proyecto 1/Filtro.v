`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:24:24 04/16/2015 
// Design Name: 
// Module Name:    Filtro 
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
module Filtro #(parameter  decim=14, magn=8, N = decim+magn+1)(
input wire clock, gen_enable, reset, clockRegPipe,
input wire signed[N-1:0] b0,a1,b1,a2,b2,
input wire signed[N-1:0] DataU,
output wire signed[N-1:0] DataY
    );

wire signed [N-1:0] outSuma1,outMult1,outRegPipe1,outMult2,outMult3,outRegPipe2,outMult4,outMult5,outSuma2,outSuma3,outReg1,outReg2,outReg3,outReg4,outReg5,outReg6,outReg7,outReg8,outReg9;


Sumador #(.N(N)) Suma1 (
	.DataA(DataU),
	.DataB(outReg3),
	.Suma(outSuma1)
);

Sumador #(.N(N)) Suma2 (
	.DataA(outReg4),
	.DataB(outReg7),
	.Suma(outSuma2)
);

Sumador #(.N(N)) Suma3 (
	.DataA(outReg5),
	.DataB(outReg9),
	.Suma(outSuma3)
);


Sumador #(.N(N)) Suma4 (
	.DataA(outReg2),
	.DataB(outReg6),
	.Suma(DataY)
);
 
Multiplicacion #(.magn(magn),.decim(decim)) b_0 (
	.A(outReg1),
	.B(b0),
	.ResulMult(outMult1)
);


Multiplicacion #(.magn(magn),.decim(decim)) a_1 (
	.A(outRegPipe1),
	.B(a1),
	.ResulMult(outMult2)
);

Multiplicacion #(.magn(magn),.decim(decim)) b_1 (
	.A(outRegPipe1),
	.B(b1),
	.ResulMult(outMult3)
);

Multiplicacion #(.magn(magn),.decim(decim)) a_2 (
	.A(outReg8),
	.B(a2),
	.ResulMult(outMult4)
);

Multiplicacion #(.magn(magn),.decim(decim)) b_2 (
	.A(outRegPipe2),
	.B(b2),
	.ResulMult(outMult5)
);

RegOpe #(.N(N)) Reg1 (
    .clk(clock), 
    .rst(reset), 
    .entrada(outSuma1), 
    .salida(outReg1)
    );

RegOpe #(.N(N)) Reg2 (
    .clk(clock), 
    .rst(reset), 
    .entrada(outMult1), 
    .salida(outReg2)
    );

RegOpe #(.N(N)) Reg3 (
    .clk(clock), 
    .rst(reset), 
    .entrada(outSuma2), 
    .salida(outReg3)
    );
	 
RegOpe #(.N(N)) Reg4 (
    .clk(clock), 
    .rst(reset), 
    .entrada(outMult2), 
    .salida(outReg4)
    );
	 
RegOpe #(.N(N)) Reg5 (
    .clk(clock), 
    .rst(reset), 
    .entrada(outMult3), 
    .salida(outReg5)
    );
	 
RegOpe #(.N(N)) Reg6 (
    .clk(clock), 
    .rst(reset), 
    .entrada(outSuma3), 
    .salida(outReg6)
    );
	 
RegOpe #(.N(N)) Reg7 (
    .clk(clock), 
    .rst(reset), 
    .entrada(outMult4), 
    .salida(outReg7)
    );
	 
RegOpe #(.N(N)) Reg8 (
    .clk(clock), 
    .rst(reset), 
    .entrada(outRegPipe2), 
    .salida(outReg8)
    );
	 
RegOpe #(.N(N)) Reg9 (
    .clk(clock), 
    .rst(reset), 
    .entrada(outMult5), 
    .salida(outReg9)
    );
	 
Registro_Pipeline #(.N(N)) Registro1(
	.clk(clockRegPipe),
	.reset(reset),
	.dato_entrada(outReg1),
	.enable(gen_enable),
	.salida(outRegPipe1)
);

Registro_Pipeline #(.N(N)) Registro2(
	.clk(clockRegPipe),
	.reset(reset),
	.dato_entrada(outRegPipe1),
	.enable(gen_enable),
	.salida(outRegPipe2)
);

endmodule

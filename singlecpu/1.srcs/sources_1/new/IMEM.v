`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/25 16:59:05
// Design Name: 
// Module Name: IMEM
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module IMEM(
    input clk,
    input [31:0]Address,
    output [4:0] IM2521,IM2016,IM1511,IM106,
    output [25:0] IM2500,
    output [15:0] IM1500,
    output [5:0] IM3126,
    output [5:0] IM0500
    );
    //∑÷≈‰ 64KB ROM£¨
    wire [31:0]Ins;
    assign IM2521 = Ins[25:21];
    assign IM2016 = Ins[20:16];
    assign IM1511 = Ins[15:11];
    assign IM2500 = Ins[25:0];
    assign IM1500 = Ins[15:0];
    assign IM3126 = Ins[31:26];
    assign IM0500 = Ins[5:0];
    assign IM106 = Ins[10:6];
prgrom instmem(
    .clka(clk), // input wire clka
    .addra(Address[15:2]), // input wire [13 : 0] addra
    .douta(Ins) // output wire [31 : 0] douta
);
endmodule

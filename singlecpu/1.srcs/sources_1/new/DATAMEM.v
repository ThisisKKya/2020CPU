`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/25 16:18:17
// Design Name: 
// Module Name: DATAMEM
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


module DATAMEM(
    input[31:0] address,
    input[31:0] WriteData,
    input MemWrite,
    input clk,
    output [31:0] ReadData
    );
    wire clock;
    assign clock = !clk;
 // 因为使用芯片的固有延迟，RAM 的地址
//线来不及在时钟上升沿准备好, 使得时钟上升沿数据读出有误，
//所以采用反相时钟，使得读出数据比地址准备好要晚大约半个时钟，从而得到正确地址。

// 分配 64KB RAM
RAM RAM (
    .clka(clock), // input wire clka
    .wea(MemWrite), // input wire [0 : 0] wea
    .addra(address[15:2]), // input wire [13 : 0] addra
    .dina(WriteData), // input wire [31 : 0] dina
    .douta(ReadData) // output wire [31 : 0] douta
);
endmodule

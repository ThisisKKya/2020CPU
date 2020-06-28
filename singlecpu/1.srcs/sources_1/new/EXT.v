`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/25 16:06:10
// Design Name: 
// Module Name: EXT
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


module EXT(
    input [15:0] IMM,
    input EXTOp,
    output [31:0] ExtIMM
    );
    assign ExtIMM[15:0] = IMM;
    assign ExtIMM[31:16] = EXTOp ? (IMM[15]?16'hffff:16'h0000):16'h0000;
endmodule

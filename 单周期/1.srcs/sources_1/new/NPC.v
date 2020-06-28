`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/25 13:54:25
// Design Name: 
// Module Name: NPC
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


module NPC(
    input clk,
    input reset,
    input [31:0]PC,
    input [25:0]IMM,
    input [31:0]RD1,
    input [1:0]NPCOp,
    output reg [31:0]NPC,
    output reg [31:0]PC4
    );
    wire [31:0]ExtIMM;
    assign ExtIMM[15:0] = IMM;
    assign ExtIMM[31:16] =IMM[15]?16'hffff:16'h0000;
    always@(posedge clk or posedge reset)
    begin
        if(reset)
            PC4 <= 0;
        else
            PC4 <= PC + 4;
    end
    always@(*)
    begin
        if(reset)
        begin
            NPC = 0;
        end
        else
        begin
            case(NPCOp)
            2'b00:
            begin
                NPC = PC + 4;
            end
            2'b01:
            begin
                NPC = PC+4 + ExtIMM*4;
            end
            2'b10:
            begin
                NPC = {PC[31:28],IMM,2'b00};
            end
            2'b11:
                NPC = RD1;
            endcase
        end
    end
endmodule

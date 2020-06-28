`timescale 1ns / 1ps

module top(
    input clk,
    input reset
    );



wire [31:0] NPCDO,PCDO,RD1,RD2,PC4,ALUDO,DMDO,EXTDO,WD;

wire [25:0] IM2500;

wire [15:0] IM1500;

wire [5:0] IM3126,IM0500;

wire [4:0] IM2521,IM2016,IM1511,a3,IM106;

wire [3:0] ALUOp;

wire [1:0] NPCOp,WRSel,WDSel;

wire RFWr,Zero,EXTOp,MemWrite;
wire [1:0]ASel,BSel;
//debug signals
wire [31:0] debug_wb_pc;
wire debug_wb_rf_wen;
wire [4:0] debug_wb_rf_wnum;
wire[31:0] debug_wb_rf_wdata;
wire[31:0] debug_ALU_A,debug_ALU_B;

assign debug_wb_pc = PCDO;
assign debug_wb_rf_wen = RFWr;
assign debug_wb_rf_wnum = a3;
assign debug_wb_rf_wdata = WD;

CtrlUnit CtrlUnit(.Op(IM3126),
                  .Func(IM0500),
                  .Zero(Zero),
                  .DMWr(MemWrite),
                  .BSel(BSel),
                  .ASel(ASel),
                  .EXTOp(EXTOp),
                  .RFWr(RFWr),
                  .NPCOp(NPCOp),
                  .WRSel(WRSel),
                  .WDSel(WDSel),
                  .ALUOp(ALUOp),
                  .reset(reset)
                  );
PC PC(.clk(clk),.reset(reset),.di(NPCDO),.addr(PCDO));
NPC NPC(.clk(clk),.reset(reset),.PC(PCDO),.IMM(IM2500),.RD1(RD1),.NPCOp(NPCOp),.NPC(NPCDO),
        .PC4(PC4));
IMEM IMEM(.clk(clk),
          .Address(PCDO),
          .IM2521(IM2521),
          .IM2016(IM2016),
          .IM1511(IM1511),
          .IM2500(IM2500),
          .IM1500(IM1500),
          .IM3126(IM3126),
          .IM0500(IM0500),
          .IM106(IM106));
RF RF(.clk(clk),
      .reset(reset),
      .a1(IM2521),
      .a2(IM2016),
      .a3(a3),
      .rd(IM1511),
      .rt(IM2016),
      .ALU(ALUDO),
      .RD(DMDO),
      .PC4(PC4),
      .RFWr(RFWr),
      .WRSel(WRSel),
      .WDSel(WDSel),
      .rd1(RD1),
      .rd2(RD2),
      .wd(WD));
ALU ALU(.ALUOp(ALUOp),
        .IM106(IM106),
        .RD1(RD1),
        .RD2(RD2),
        .Ext(EXTDO),
        .ASel(ASel),
        .BSel(BSel),
        .Zero(Zero),
        .C(ALUDO),
        .A(debug_ALU_A),
        .B(debug_ALU_B));
EXT EXT(.IMM(IM1500),
        .EXTOp(EXTOp),
        .ExtIMM(EXTDO));
DATAMEM DATAMEM(.address(ALUDO),
                .WriteData(RD2),
                .MemWrite(MemWrite),
                .clk(clk),
                .ReadData(DMDO));
endmodule

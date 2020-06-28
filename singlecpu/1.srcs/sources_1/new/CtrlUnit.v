`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/25 19:09:55
// Design Name: 
// Module Name: CtrlUnit
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


module CtrlUnit(
    input [5:0]Op,
    input [5:0]Func,
    input reset,
    input Zero,
    output DMWr,EXTOp,//ZeroG,
    output [1:0]NPCOp,WRSel,WDSel,
    output [3:0]ALUOp,
    output [1:0]BSel,ASel,
    output reg RFWr
    );
    wire RType;
    wire _add,_addu,_sub,_subu,_and,_or,_xor,_nor,_sllv,_srlv,_srav,_jr,_addi,_addiu,_andi,_ori,_xori,_sltiu,_lui,_lw,_sw,_beq,_j,_jal;
    wire _slt,_sltu,_sll,_srl,_sra,_bne,_bgtz;//选做
    assign RType = ~|Op;
    //选做
    assign _slt = RType&Func[5]&~Func[4]&Func[3]&~Func[2]&Func[1]&~Func[0];
    assign _sltu = RType&Func[5]&~Func[4]&Func[3]&~Func[2]&Func[1]&Func[0];
    assign _sll = RType&~Func[5]&~Func[4]&~Func[3]&~Func[2]&~Func[1]&~Func[0];
    assign _srl = RType&~Func[5]&~Func[4]&~Func[3]&~Func[2]&Func[1]&~Func[0];
    assign _sra = RType&~Func[5]&~Func[4]&~Func[3]&~Func[2]&Func[1]&Func[0];
    assign _bne = ~Op[5]&~Op[4]&~Op[3]&Op[2]&~Op[1]&Op[0];
    assign _bgtz = ~Op[5]&~Op[4]&~Op[3]&Op[2]&Op[1]&Op[0];
    
    assign _add = RType&Func[5]&~Func[4]&~Func[3]&~Func[2]&~Func[1]&~Func[0];
	assign _addu = RType&Func[5]&~Func[4]&~Func[3]&~Func[2]&~Func[1]&Func[0];
	assign _sub = RType&Func[5]&~Func[4]&~Func[3]&~Func[2]&Func[1]&~Func[0];
	assign _subu = RType&Func[5]&~Func[4]&~Func[3]&~Func[2]&Func[1]&Func[0];
	assign _and = RType&Func[5]&~Func[4]&~Func[3]&Func[2]&~Func[1]&~Func[0];
	assign _or = RType&Func[5]&~Func[4]&~Func[3]&Func[2]&~Func[1]&Func[0];
	assign _xor = RType&Func[5]&~Func[4]&~Func[3]&Func[2]&Func[1]&~Func[0];
	assign _nor = RType&Func[5]&~Func[4]&~Func[3]&Func[2]&Func[1]&Func[0];
	assign _sllv = RType&~Func[5]&~Func[4]&~Func[3]&Func[2]&~Func[1]&~Func[0];
	assign _srlv = RType&~Func[5]&~Func[4]&~Func[3]&Func[2]&Func[1]&~Func[0];
	assign _srav = RType&~Func[5]&~Func[4]&~Func[3]&Func[2]&Func[1]&Func[0];
	assign _jr = RType&~Func[5]&~Func[4]&Func[3]&~Func[2]&~Func[1]&~Func[0];
	assign _addi = ~Op[5]&~Op[4]&Op[3]&~Op[2]&~Op[1]&~Op[0];
	assign _addiu = ~Op[5]&~Op[4]&Op[3]&~Op[2]&~Op[1]&Op[0];
	assign _andi = ~Op[5]&~Op[4]&Op[3]&Op[2]&~Op[1]&~Op[0];
	assign _ori = ~Op[5]&~Op[4]&Op[3]&Op[2]&~Op[1]&Op[0];
	assign _xori = ~Op[5]&~Op[4]&Op[3]&Op[2]&Op[1]&~Op[0];
	assign _sltiu = ~Op[5]&~Op[4]&Op[3]&~Op[2]&Op[1]&Op[0];
	assign _lui = ~Op[5]&~Op[4]&Op[3]&Op[2]&Op[1]&Op[0];
	assign _lw = Op[5]&~Op[4]&~Op[3]&~Op[2]&Op[1]&Op[0];
	assign _sw = Op[5]&~Op[4]&Op[3]&~Op[2]&Op[1]&Op[0];
	assign _beq = ~Op[5]&~Op[4]&~Op[3]&Op[2]&~Op[1]&~Op[0];
	assign _j = ~Op[5]&~Op[4]&~Op[3]&~Op[2]&Op[1]&~Op[0];
	assign _jal = ~Op[5]&~Op[4]&~Op[3]&~Op[2]&Op[1]&Op[0];
	
	assign NPCOp[0] = _jr|(_beq&Zero)|(_bne&!Zero)|(_bgtz&Zero);
	assign NPCOp[1] = _jr|_j|_jal;
	
	assign EXTOp = _addi|_addiu|_sltiu|_lw|_sw|_beq|_bne|_bgtz;
	assign ALUOp[0] =_sub|_subu|_sltiu|_beq|_or|_ori|_nor|_srlv|_sltiu|_sltu|_bne|_srl;
	assign ALUOp[1] = _and|_andi|_or|_ori|_sllv|_srlv|_lui|_slt|_sll|_srl|_bgtz;
	assign ALUOp[2] = _nor|_sllv|_srlv|_lui|_xor|_xori|_sll|_srl;
    assign ALUOp[3] = _srav|_sltiu|_slt|_sltu|_sra|_bgtz; 
    assign DMWr = _sw;
    assign WRSel[0] = _addi|_addiu|_andi|_ori|_xori|_sltiu|_lui|_lw;
    assign WRSel[1] = _jal;
    assign WDSel[0] = _lw;
    assign WDSel[1] = _jal; 
    assign ASel[0] = _lui;
    assign ASel[1] = _sll|_srl|_sra;
    assign BSel[0] = _addi|_addiu|_andi|_ori|_xori|_sltiu|_lui|_lw|_sw;
    assign BSel[1] = 0;
    always@(*)
    begin
        if(reset)
            RFWr = 0;
        else
            RFWr = _add|_addu|_sub|_subu|_and|_or|_xor|_nor|_sllv|_srlv|_srav|_addi|_addiu|_andi|_ori|_xori|_sltiu|_lui|_lw|_jal|_slt|_sltu|_sll|_srl|_sra;
    end
    //assign ZeroG = _beq;
endmodule


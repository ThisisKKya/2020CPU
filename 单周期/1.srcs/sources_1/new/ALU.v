`timescale 1ns / 1ps

module ALU(
    input [3:0]ALUOp,//0000.add /0001.sub /0010.and/ 0011.or/ 0100.xor /0101.nor /0110.sll /0111.srl /1000.sra 
    input [31:0]RD1,
    input [31:0]RD2,
    input [31:0]Ext,
    input ASel,
    input BSel,
    output reg Zero,
    output reg [31:0] C,
    output [31:0]A,B
    );
    reg sign;
    assign A = ASel?16:RD1;//0ÎªRD1£¬1Îª0x10¼´16£¬luiÖ¸Áî
    assign B = BSel?Ext:RD2;
    always@(*)
    begin
		      case(ALUOp)
				    // add
					 4'b0000: begin
					     C = A + B;
						  Zero = (C == 0)? 1 : 0;
					 end
					 // A - B
					 4'b0001: begin
					     C = A - B;
						  Zero = (C == 0)? 1 : 0;
					 end
                     // A And B
					 4'b0010: begin
					     C = A & B;
						  Zero = (C == 0)? 1 : 0;
					 end
					 // A Or B
					 4'b0011: begin
					     C = A | B;
						  Zero = (C == 0)? 1 : 0;
					 end
                    //A Xor B
					 4'b0100: begin
					     C = A ^ B;
						  Zero = (C == 0)? 1 : 0;
					 end
					 // A Nor B
					 4'b0101: begin
					     C = ~(A|B);
						 Zero = (C == 0)? 1 : 0;
					 end
					 // sll
					 4'b0110: begin
					     C = B<<A;
						  Zero = (C == 0)? 1 : 0;
					 end
					 4'b0111: begin
					     C = B>>A;
					     Zero = (C == 0)?1 : 0;
                     end
					 4'b1000:begin
					     C = ($signed(B)) >>>A;
					     Zero = (C == 0)?1 : 0;
                     end
                     4'b1001:begin
                        C = (A<B)? 1:0;
                        Zero = (C == 0)?1 : 0;
                    end
		      endcase
    end
    
endmodule

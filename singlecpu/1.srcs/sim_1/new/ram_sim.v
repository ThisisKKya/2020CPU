`timescale 1ns / 1ps
module ram_sim( );
    // input
    reg[31:0] address = 32'h00000010; //����ִ�е�Ԫ����� alu_result
    reg[31:0] write_data = 32'ha0000000; //�������뵥Ԫ�� read_data2
    reg Memwrite = 1'b0; //���Կ��Ƶ�Ԫ
    reg clock = 1'b0; 
    // output
    wire[31:0] read_data;

    DATAMEM Uram(address,write_data,Memwrite,clock,read_data);

    initial begin
    #200 begin write_data = 32'hA00000F5;Memwrite = 1'b1; end
    #200 Memwrite = 1'b0;
    end
    always #50 clock = ~clock; 
endmodule
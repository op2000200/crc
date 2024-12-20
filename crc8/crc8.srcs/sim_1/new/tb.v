`timescale 1ns / 1ps

module tb_crc8_dvb_s2;

    reg clk;
    reg rst;
    reg mode;
    reg data_in;

    wire data_out;
    reg [31:0] input_data [9:0];
    reg [7:0] crc [9:0];

    crc8_dvb_s2 uut (
        .clk(clk),
        .rst(rst),
        .mode(mode),
        .data_in(data_in),
        .data_out(data_out)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        input_data[0] = 32'b10100101101001011010010110100101;
        input_data[1] = 32'b11011111101000110100010001011001;
        input_data[2] = 32'b11011011100110011100001010101011;
        input_data[3] = 32'b10101011001100111110001100001011;
        input_data[4] = 32'b11010111011011100110101111000000;
        input_data[5] = 32'b10110001111001001011111101100010;
        input_data[6] = 32'b11101000001000100111011100111011;
        input_data[7] = 32'b11001011111101010010011001001010;
        input_data[8] = 32'b10011100100110100001010110101011;
        input_data[9] = 32'b11101100110011101011001011111110;
        for (integer k = 0; k < 10; k = k + 1) begin
            rst = 1;
            mode = 0;
            data_in = 0;
    
            #10;
            rst = 0;
    
            for (integer i = 0; i < 8; i = i + 1) begin
                #10 data_in = input_data[k][i];
            end
    
            #10 mode = 1;
            #10;
            for (integer j = 0; j < 8; j = j + 1) begin
                
                crc[k][j] <= data_out; 
                #10;
            end
            #10 $display("Time: %0t, line: %b, crc: %b", $time, input_data[k], crc[k]);
        end

        #10 $finish;
    end

endmodule

`timescale 1ns / 1ps

module crc8_dvb_s2 (
    input wire clk,
    input wire rst,
    input wire mode,
    input wire data_in,
    output reg data_out
);

    reg [7:0] crc;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            crc <= 8'b00000000;
        end else begin
            case (mode)
                1'b0: begin
                    //calc crc and packet to out
                    data_out <= data_in;
                    crc[0] <= crc[7] ^ data_in;
                    crc[1] <= crc[0];
                    crc[2] <= crc[1] ^ (crc[7] ^ data_in);
                    crc[3] <= crc[2];
                    crc[4] <= crc[3] ^ (crc[7] ^ data_in);
                    crc[5] <= crc[4];
                    crc[6] <= crc[5] ^ (crc[7] ^ data_in);
                    crc[7] <= crc[6] ^ (crc[7] ^ data_in);
                end
                1'b1: begin
                    //crc to out
                    data_out <= crc[0];
                    crc <= {0, crc[7:1]};
                end
            endcase
        end
    end
endmodule
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/08/2026 01:37:24 PM
// Design Name: 
// Module Name: MBR
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

module MBR (
    input  wire        clk,
    input  wire        rst,
    input  wire        MBRld,    // Load Enable: Tín hiệu cho phép nạp dữ liệu
    input  wire [31:0] MBRin,    // Đầu vào dữ liệu (Từ Memory Read hoặc từ Bus nội bộ để Write)
    
    output reg  [31:0] MBRout    // Đầu ra dữ liệu (Đẩy lên Bus nội bộ hoặc đưa vào Memory Write)
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            MBRout <= 32'b0;
        end else begin
            if (MBRld) begin
                MBRout <= MBRin;
            end
        end
    end

endmodule
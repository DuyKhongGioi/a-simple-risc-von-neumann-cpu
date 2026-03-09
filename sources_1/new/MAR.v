`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/08/2026 01:36:26 PM
// Design Name: 
// Module Name: MAR
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

module MAR (
    input  wire        clk,
    input  wire        rst,
    input  wire        MARld,    // Load Enable: Tín hiệu cho phép nạp địa chỉ
    input  wire [31:0] MARin,    // Đầu vào địa chỉ (Từ PC hoặc Bus nội bộ)
    
    output reg  [31:0] MARout    // Đầu ra địa chỉ (Nối thẳng tới cổng Address của Memory)
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            MARout <= 32'b0;
        end else begin
            if (MARld) begin
                MARout <= MARin;
            end
        end
    end

endmodule

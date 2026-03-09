`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/08/2026 02:54:54 PM
// Design Name: 
// Module Name: r0
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



module r0 (
    input  wire        clk,
    input  wire        rst,
    input  wire        r0ld,    // Load Enable: Tín hiệu cho phép nạp dữ liệu
    input  wire [31:0] r0in,    // Đầu vào dữ liệu (Từ Memory Read hoặc từ Bus nội bộ để Write)
    
    output reg  [31:0] r0out    // Đầu ra dữ liệu (Đẩy lên Bus nội bộ hoặc đưa vào Memory Write)
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            r0out <= 32'b0;
        end else begin
            if (r0ld) begin
                r0out <= r0in;
            end
        end
    end

endmodule

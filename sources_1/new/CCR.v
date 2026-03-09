`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/08/2026 01:19:20 PM
// Design Name: 
// Module Name: CCR
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

module CCR (
    input  wire clk,
    input  wire rst,
    input  wire CCR_we,       // Write Enable: Tín hiệu cho phép cập nhật cờ (từ Control Unit)
    input  wire alu_zero,     // Dữ liệu cờ Zero lấy trực tiếp từ output 'isZ' của ALU
    
    output reg  Z_flag        // Cờ Zero đã được lưu lại để Control Unit đọc
);

    // Khối cập nhật thanh ghi trạng thái (Đồng bộ theo sườn lên của xung nhịp)
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Khi reset, xóa cờ Zero về 0
            Z_flag <= 1'b0;
        end else begin
            // Chỉ cập nhật CCR khi Control Unit cho phép (CCR_we = 1)
            // Thường bật = 1 ở các lệnh: CMP, ADD, SUB, AND, OR, NOT
            // Thường tắt = 0 ở các lệnh: BRA, BEQ, BNE, MOV, LDR, STR, NOP
            if (CCR_we) begin
                Z_flag <= alu_zero;
            end
        end
    end

endmodule
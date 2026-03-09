`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/08/2026 01:26:29 PM
// Design Name: 
// Module Name: IR
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

module IR (
    input  wire        clk,
    input  wire        rst,
    input  wire        IRld,       // Load Enable: Tín hiệu cho phép nạp lệnh từ Control Unit
    input  wire [31:0] IRin,       // Lệnh 32-bit đọc về từ bộ nhớ (Memory)

    output reg  [31:0] IRout,      // Toàn bộ lệnh 32-bit lưu trong thanh ghi
    output wire [15:0] literal,    // 16-bit hằng số/địa chỉ (Thay thế cho dir_addr cũ)
    output wire [6:0]  opcode,     // 7-bit mã lệnh (Class + Op-code)
    output wire [2:0]  rD,         // 3-bit địa chỉ thanh ghi đích
    output wire [2:0]  rS1,        // 3-bit địa chỉ thanh ghi nguồn 1
    output wire [2:0]  rS2         // 3-bit địa chỉ thanh ghi nguồn 2
);

    // --------------------------------------------------------
    // KHỐI NẠP LỆNH: Hoạt động đồng bộ theo sườn lên của Clock
    // --------------------------------------------------------
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            IRout <= 32'b0;
        end else begin
            if (IRld) begin
                IRout <= IRin;
            end
        end
    end

    // --------------------------------------------------------
    // KHỐI GIẢI MÃ NHANH: Trích xuất các trường từ lệnh 32-bit
    // Mạch tổ hợp, cập nhật ngay lập tức khi IRout thay đổi
    // --------------------------------------------------------
    assign opcode  = IRout[31:25]; // Bit [31:25] đưa vào Control Unit
    assign rD      = IRout[24:22]; // Bit [24:22] đưa vào chân RFwa của Register File
    assign rS1     = IRout[21:19]; // Bit [21:19] đưa vào chân RFr1a của Register File
    assign rS2     = IRout[18:16]; // Bit [18:16] đưa vào chân RFr2a của Register File
    assign literal = IRout[15:0];  // Bit [15:0] đưa thẳng vào Bus hoặc PC (Lệnh Branch)

endmodule
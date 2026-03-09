`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/08/2026 01:33:33 PM
// Design Name: 
// Module Name: PC
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

module PC (
    input  wire        clk,      // Bắt buộc phải có xung nhịp hệ thống
    input  wire        PCclr,    // Clear/Reset (Tích cực mức cao)
    input  wire        PCinc,    // Increment Enable: Cho phép tăng PC lên 1
    input  wire        PCld,     // Load Enable: Cho phép nạp giá trị nhảy (Branch)
    input  wire [31:0] PCin,     // Giá trị địa chỉ nhảy nạp vào (Từ IR hoặc ALU)
    
    output reg  [31:0] PCout     // Giá trị địa chỉ hiện tại xuất ra (Đưa tới MAR)
);

    // Mạch đồng bộ sử dụng 1 Clock duy nhất
    always @(posedge clk or posedge PCclr) begin
        if (PCclr) begin
            // Reset bất đồng bộ: Xóa PC về 0 ngay lập tức
            PCout <= 32'b0;
        end else begin
            // Mạch ưu tiên: Nạp giá trị nhảy (Branch) được ưu tiên cao hơn việc tăng PC
            if (PCld) begin
                PCout <= PCin;
            end else if (PCinc) begin
                PCout <= PCout + 32'd1;
            end
        end
    end

endmodule
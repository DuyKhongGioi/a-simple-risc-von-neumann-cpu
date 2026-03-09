`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/08/2026 02:11:58 PM
// Design Name: 
// Module Name: RAM
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


module RAM #(
    parameter DATA_W = 32,
    parameter ADDR_W = 16
)(
    input  wire clk,
    input  wire mem_we,           // Memory Write Enable (từ CU)
    input  wire mem_re,           // Memory Read Enable (từ CU)
    input  wire [ADDR_W-1:0] addr,   // Địa chỉ (từ MAR của Datapath)
    input  wire [DATA_W-1:0] data_in, // Dữ liệu ghi (từ MBR của Datapath)
    
    output wire [DATA_W-1:0] data_out // Dữ liệu xuất ra (đưa vào MBR của Datapath)
);

    // Khai báo mảng bộ nhớ (Ví dụ: 256 ô nhớ, mỗi ô 16-bit)
    // Trên thực tế có thể tăng lên tùy tài nguyên FPGA
    reg [DATA_W-1:0] memory [0:255];

    // --------------------------------------------------------
    // QUÁ TRÌNH ĐỌC (Bất đồng bộ)
    // --------------------------------------------------------
    // Nếu mem_re = 1, xuất dữ liệu ngay lập tức. Nếu = 0, đưa về tổng trở cao (High-Z).
    assign data_out = (mem_re) ? memory[addr[7:0]] : 32'bz;

    // --------------------------------------------------------
    // QUÁ TRÌNH GHI (Đồng bộ)
    // --------------------------------------------------------
    always @(posedge clk) begin
        if (mem_we) begin
            memory[addr[7:0]] <= data_in;
        end
    end

    // --------------------------------------------------------
    // NẠP CHƯƠNG TRÌNH MẪU KHI KHỞI ĐỘNG
    // --------------------------------------------------------
    initial begin
        // Để test, bạn tạo một file "program.mem" chứa mã Hex của các lệnh
        // Vivado sẽ tự động nạp file này vào RAM khi chạy Simulation hoặc nạp board
        $readmemh("program.mem", memory); 
    end

endmodule

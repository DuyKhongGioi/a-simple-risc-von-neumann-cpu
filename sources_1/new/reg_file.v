`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/08/2026 01:12:32 PM
// Design Name: 
// Module Name: reg_file
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

`timescale 1ns / 1ps

module reg_file #(
    parameter DATA_WIDTH = 16,
    parameter ADDR_WIDTH = 3  // 3-bit tương ứng với 8 thanh ghi (R0-R7)
)(
    input  wire clk,
    input  wire rst,          // Tích cực mức cao (High active) giống VHDL
    input  wire RFwe,         // Write Enable
    input  wire RFr1e,        // Read Enable 1
    input  wire RFr2e,        // Read Enable 2
    
    input  wire [ADDR_WIDTH-1:0] RFwa,  // Write Address (rD)
    input  wire [ADDR_WIDTH-1:0] RFr1a, // Read Address 1 (rS1)
    input  wire [ADDR_WIDTH-1:0] RFr2a, // Read Address 2 (rS2)
    input  wire [DATA_WIDTH-1:0] RFin,   // Write Data
    
    output wire [DATA_WIDTH-1:0] RFr1,  // Read Data 1
    output wire [DATA_WIDTH-1:0] RFr2   // Read Data 2
);

    // Khai báo mảng 8 thanh ghi, mỗi thanh ghi rộng 16-bit
    reg [DATA_WIDTH-1:0] rf [0:(1<<ADDR_WIDTH)-1];
    integer i;

    // --------------------------------------------------------
    // QUÁ TRÌNH GHI: Ghi đồng bộ (Có Clock)
    // --------------------------------------------------------
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Khi Reset, xóa toàn bộ 8 thanh ghi về 0
            for (i = 0; i < (1<<ADDR_WIDTH); i = i + 1) begin
                rf[i] <= {DATA_WIDTH{1'b0}};
            end
        end else begin
            // Khi có tín hiệu cho phép ghi
            if (RFwe) begin
                rf[RFwa] <= RFin;
            end
        end
    end

    // --------------------------------------------------------
    // QUÁ TRÌNH ĐỌC: Đọc bất đồng bộ (Combinational Logic)
    // --------------------------------------------------------
    // Nếu tín hiệu Read Enable (RFr1e/RFr2e) bật, xuất dữ liệu. 
    // Nếu không, xuất toàn số 0. Dùng lệnh assign để dữ liệu ra tức thời.
    
    assign RFr1 = (RFr1e) ? rf[RFr1a] : {DATA_WIDTH{1'b0}};
    assign RFr2 = (RFr2e) ? rf[RFr2a] : {DATA_WIDTH{1'b0}};

endmodule

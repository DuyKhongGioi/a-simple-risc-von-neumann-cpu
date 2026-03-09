`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/08/2026 01:38:48 PM
// Design Name: 
// Module Name: datapath
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

module datapath #(
    parameter DATA_W = 32,
    parameter ADDR_W = 16
)
    (
    input wire clk,
    input wire rst,
    
    input wire [15:0] pc_val,
    input wire [15:0] literal,
    input wire [31:0] mem_data,
    input wire mar_sel,
    input wire mar_ld,
    input wire [1:0] mbr_sel,
    input wire mbr_ld,
    input wire [2:0] ALUop,
    output wire [31:0] mar_out,
    output wire [31:0] mbr_out,
    input wire [2:0] rD,
    input wire [2:0] rS1,
    input wire [2:0] rS2,
    
    input wire RFwe,
    input wire RFr1e,
    input wire RFr2e,
    input wire oprB_sel,
    input wire CCR_we,
    output wire zFlag,
    output wire isZ
    );
    
    wire [31:0] mbr_tmp, mar_tmp;
    wire [31:0] rS2_tmp;
    wire [31:0] r0_out;
    wire [31:0] ALUout;
    wire [31:0] rS1_out;
    wire [31:0] rS2_out;
        
    assign mar_tmp = (mar_sel == 1'b0) ? {16'b0,pc_val} : {16'd0, literal};
    assign mbr_tmp = (mbr_sel == 2'b00) ? ALUout :
                     (mbr_sel == 2'b01) ? mem_data :
                     (mbr_sel == 2'b10) ? {16'd0,literal} : 32'd0;
    assign rS2_tmp = (oprB_sel == 1'b0) ? mbr_out : rS2_out;
    
    ALU #(.DATA_WIDTH(32)) alu_inst
        (.oprA(rS1_out),
         .oprB(rS2_tmp),
         .ALUop(ALUop),
         .ALUout(ALUout),
         .isZ(isZ)
         );
    MAR mar_inst
    (
    .clk(clk),
    .rst(rst),
    .MARld(mar_ld),    // Load Enable: Tín hiệu cho phép nạp địa chỉ
    .MARin(mar_tmp),    // Đầu vào địa chỉ (Từ PC hoặc Bus nội bộ)
    .MARout(mar_out)    // Đầu ra địa chỉ (Nối thẳng tới cổng Address của Memory)
    );
    MBR mbr_inst
    (
    .clk(clk),
    .rst(rst),
    .MBRld(mbr_ld),    // Load Enable: Tín hiệu cho phép nạp địa chỉ
    .MBRin(mbr_tmp),    // Đầu vào địa chỉ (Từ PC hoặc Bus nội bộ)
    .MBRout(mbr_out)    // Đầu ra địa chỉ (Nối thẳng tới cổng Address của Memory)
    );

    reg_file #(
        .DATA_WIDTH(32),
        .ADDR_WIDTH(3)
    ) rf_inst (
        .clk(clk),
        .rst(rst),
    
        .RFwe(RFwe),
        .RFr1e(RFr1e),
        .RFr2e(RFr2e),
    
        .RFwa(rD),
        .RFr1a(rS1),
        .RFr2a(rS2),
    
        .RFin(ALUout),
    
        .RFr1(rS1_out),
        .RFr2(rS2_out)
    );
    
    CCR ccr_inst(
    .clk(clk),
    .rst(rst),
    .CCR_we(CCR_we),
    .alu_zero(isZ),
    .Z_flag(zFlag)
    );
    
   
endmodule

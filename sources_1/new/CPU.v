`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/08/2026 02:12:34 PM
// Design Name: 
// Module Name: CPU
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
module CPU (
    input wire clk,
    input wire rst
);

    // =============================
    // Wire kết nối Control <-> Datapath
    // =============================

    wire mar_sel;
    wire mar_ld;
    wire [1:0] mbr_sel;
    wire mbr_ld;
    wire [2:0] ALUop;
    wire r0_ld;

    wire [31:0] PCout;
    wire [15:0] literal;
    wire [2:0] rD;
    wire [2:0] rS1;
    wire [2:0] rS2;
    
    wire RFwe;
    wire RFr1e;
    wire RFr2e;
    wire oprB_sel;

    // =============================
    // Wire kết nối Memory
    // =============================

    wire Mre;
    wire Mwe;

    wire [31:0] mar_out;
    wire [31:0] mbr_out;
    wire [31:0] mem_data;
    
    wire zFlag;
    wire isZ;
    wire CCR_we;

    // =============================
    // Datapath
    // =============================

    datapath datapath_inst (
        .clk(clk),
        .rst(rst),

        .pc_val(PCout[15:0]),
        .literal(literal),
        .mem_data(mem_data),

        .mar_sel(mar_sel),
        .mar_ld(mar_ld),

        .mbr_sel(mbr_sel),
        .mbr_ld(mbr_ld),

        .ALUop(ALUop),
        

        .mar_out(mar_out),
        .mbr_out(mbr_out),
        .rD(rD),
        .rS1(rS1),
        .rS2(rS2),
    
        .RFwe(RFwe),
        .RFr1e(RFr1e),
        .RFr2e(RFr2e),
        .oprB_sel(oprB_sel),
        .CCR_we(CCR_we),
        .zFlag(zFlag),
        .isZ(isZ)
    );

    // =============================
    // Control Unit
    // =============================

    control_unit cu_inst (
        .clk(clk),
        .rst(rst),

        .mbr_out(mbr_out),

        .mar_sel(mar_sel),
        .mar_ld(mar_ld),

        .mbr_sel(mbr_sel),
        .mbr_ld(mbr_ld),

        .ALUop(ALUop),

        .Mre(Mre),
        .Mwe(Mwe),
        .rD(rD),
        .rS1(rS1),
        .rS2(rS2),
        .PCout(PCout),
        .literal(literal),
        .RFwe(RFwe),
        .RFr1e(RFr1e),
        .RFr2e(RFr2e),
        .oprB_sel(oprB_sel),
        .CCR_we(CCR_we),
        .zFlag(zFlag),
        .isZ(isZ)
    );

    // =============================
    // RAM
    // =============================

    RAM ram_inst (
        .clk(clk),

        .mem_we(Mwe),
        .mem_re(Mre),

        .addr(mar_out[15:0]),
        .data_in(mbr_out),

        .data_out(mem_data)
    );

endmodule
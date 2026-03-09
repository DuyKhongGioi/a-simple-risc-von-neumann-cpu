`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/08/2026 02:10:27 PM
// Design Name: 
// Module Name: control_unit
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

module control_unit (
    input wire clk,
    input wire rst,
    
    input [31:0]mbr_out,
    output wire mar_sel,
    output wire mar_ld,
    output wire [1:0] mbr_sel,
    output wire mbr_ld,
    output wire [2:0] ALUop,
    output wire Mre,
    output wire Mwe,
    output wire [31:0] PCout,
    output wire [15:0] literal,
    
    output wire [2:0] rD,
    output wire [2:0] rS1,
    output wire [2:0] rS2,
    output wire RFwe,
    output wire RFr1e,
    output wire RFr2e,
    output wire oprB_sel,
    output wire CCR_we,
    input  wire isZ,
    input  wire zFlag
);

    wire IR_ld;
    wire [31:0] IRout;
    wire [6:0] IR_opcode;
    IR ir_inst (
    .clk(clk),
    .rst(rst),
    .IRld(IR_ld),
    .IRin(mbr_out),

    .IRout(IRout),
    .literal(literal),
    .opcode(IR_opcode),
    .rD(rD),
    .rS1(rS1),
    .rS2(rS2)
);
    wire PCld;
    wire [31:0] PCin;
    wire PC_inc, PCclr;
    PC pc_inst (
    .clk(clk),
    .PCclr(PCclr),
    .PCinc(PC_inc),
    .PCld(PCld),
    .PCin(PCin),
    .PCout(PCout)
);
    assign PCin = {16'd0, literal};

controller ctrl_inst (
    .clk(clk),
    .rst(rst),

    .IR_opcode(IR_opcode),

    .mar_sel(mar_sel),
    .mar_ld(mar_ld),
    .mbr_sel(mbr_sel),
    .mbr_ld(mbr_ld),
    .ALUop(ALUop),
    .Mre(Mre),
    .Mwe(Mwe),
    .IR_ld(IR_ld),
    .PC_inc(PC_inc),
    .PCclr(PCclr),
    .RFwe(RFwe),
    .RFr1e(RFr1e),
    .RFr2e(RFr2e),
    .oprB_sel(oprB_sel),
    .isZ(isZ),
    .zFlag(zFlag),
    .CCR_we(CCR_we),
    .PCld(PCld)
);
endmodule
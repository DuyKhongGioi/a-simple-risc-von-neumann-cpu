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
    input  wire        IRld,     
    input  wire [31:0] IRin,     

    output reg  [31:0] IRout,     
    output wire [15:0] literal,    
    output wire [6:0]  opcode,     
    output wire [2:0]  rD,     
    output wire [2:0]  rS1,       
    output wire [2:0]  rS2   
);


    always @(posedge clk or posedge rst) begin
        if (rst) begin
            IRout <= 32'b0;
        end else begin
            if (IRld) begin
                IRout <= IRin;
            end
        end
    end


    assign opcode  = IRout[31:25]; 
    assign rD      = IRout[24:22];
    assign rS1     = IRout[21:19]; 
    assign rS2     = IRout[18:16]; 
    assign literal = IRout[15:0]; 

endmodule

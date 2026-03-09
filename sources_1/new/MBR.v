`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/08/2026 01:37:24 PM
// Design Name: 
// Module Name: MBR
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

module MBR (
    input  wire        clk,
    input  wire        rst,
    input  wire        MBRld,    
    input  wire [31:0] MBRin,   
    
    output reg  [31:0] MBRout 
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            MBRout <= 32'b0;
        end else begin
            if (MBRld) begin
                MBRout <= MBRin;
            end
        end
    end

endmodule

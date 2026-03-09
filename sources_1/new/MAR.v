`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/08/2026 01:36:26 PM
// Design Name: 
// Module Name: MAR
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

module MAR (
    input  wire        clk,
    input  wire        rst,
    input  wire        MARld,   
    input  wire [31:0] MARin,    
    
    output reg  [31:0] MARout    
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            MARout <= 32'b0;
        end else begin
            if (MARld) begin
                MARout <= MARin;
            end
        end
    end

endmodule

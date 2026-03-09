`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/08/2026 01:19:20 PM
// Design Name: 
// Module Name: CCR
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

module CCR (
    input  wire clk,
    input  wire rst,
    input  wire CCR_we,       
    input  wire alu_zero,   
    
    output reg  Z_flag        
);


    always @(posedge clk or posedge rst) begin
        if (rst) begin
            
            Z_flag <= 1'b0;
        end else begin
        

            if (CCR_we) begin
                Z_flag <= alu_zero;
            end
        end
    end

endmodule

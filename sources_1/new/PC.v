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
    input  wire        clk,     
    input  wire        PCclr,   
    input  wire        PCinc,  
    input  wire        PCld,     
    input  wire [31:0] PCin,    
    
    output reg  [31:0] PCout 
);


    always @(posedge clk or posedge PCclr) begin
        if (PCclr) begin
           
            PCout <= 32'b0;
        end else begin
            
            if (PCld) begin
                PCout <= PCin;
            end else if (PCinc) begin
                PCout <= PCout + 32'd1;
            end
        end
    end

endmodule

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
    input  wire mem_we,        
    input  wire mem_re,           
    input  wire [ADDR_W-1:0] addr,  
    input  wire [DATA_W-1:0] data_in, 
    
    output wire [DATA_W-1:0] data_out
);


    reg [DATA_W-1:0] memory [0:255];


    assign data_out = (mem_re) ? memory[addr[7:0]] : 32'bz;

    // --------------------------------------------------------
    // QUÁ TRÌNH GHI (Đồng bộ)
    // --------------------------------------------------------
    always @(posedge clk) begin
        if (mem_we) begin
            memory[addr[7:0]] <= data_in;
        end
    end


    initial begin

        $readmemh("program.mem", memory); 
    end

endmodule

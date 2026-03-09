`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/08/2026 12:13:53 PM
// Design Name: 
// Module Name: ALU
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

module ALU
    #(parameter DATA_WIDTH = 16)
    (
    input wire  [DATA_WIDTH - 1:0] oprA,
    input wire  [DATA_WIDTH - 1:0] oprB,
    input wire  [2:0] ALUop,         
    output reg  [DATA_WIDTH - 1:0] ALUout,
    output reg  isZ // zero flag
    );
    
    reg [DATA_WIDTH - 1:0] ALUtmp;
    
    localparam [2:0]
        ADD = 3'b000,
        SUB = 3'b001,
        AND = 3'b010,
        OR  = 3'b011,
        NOT = 3'b100,
        LDR = 3'b101,
        MOV = 3'b110;
        
    // Khối always thực thi tất cả logic của ALU
    always @* begin
        
        case (ALUop)
            ADD:     ALUtmp = oprA + oprB; 
            SUB:     ALUtmp = oprA - oprB;
            AND:     ALUtmp = oprA & oprB;
            OR:      ALUtmp = oprA | oprB;
            NOT:     ALUtmp = ~oprA;
            LDR:     ALUtmp = oprB;
            MOV:     ALUtmp = oprA;
            default: ALUtmp = {DATA_WIDTH{1'b0}};
        endcase
        
        
        ALUout = ALUtmp;
        
        
        if (ALUtmp == {DATA_WIDTH{1'b0}})
            isZ = 1'b1;
        else
            isZ = 1'b0;
    end
            
endmodule
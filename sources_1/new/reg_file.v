`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/08/2026 01:12:32 PM
// Design Name: 
// Module Name: reg_file
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

module reg_file #(
    parameter DATA_WIDTH = 16,
    parameter ADDR_WIDTH = 3  
)(
    input  wire clk,
    input  wire rst,        
    input  wire RFwe,        
    input  wire RFr1e,        
    input  wire RFr2e,     
    
    input  wire [ADDR_WIDTH-1:0] RFwa,  
    input  wire [ADDR_WIDTH-1:0] RFr1a, 
    input  wire [ADDR_WIDTH-1:0] RFr2a,
    input  wire [DATA_WIDTH-1:0] RFin,  
    
    output wire [DATA_WIDTH-1:0] RFr1,  
    output wire [DATA_WIDTH-1:0] RFr2   
);

   
    reg [DATA_WIDTH-1:0] rf [0:(1<<ADDR_WIDTH)-1];
    integer i;


    always @(posedge clk or posedge rst) begin
        if (rst) begin
          
            for (i = 0; i < (1<<ADDR_WIDTH); i = i + 1) begin
                rf[i] <= {DATA_WIDTH{1'b0}};
            end
        end else begin
            
            if (RFwe) begin
                rf[RFwa] <= RFin;
            end
        end
    end

    // --------------------------------------------------------
    // QUÁ TRÌNH ĐỌC: Đọc bất đồng bộ 
    // --------------------------------------------------------
    // Nếu tín hiệu Read Enable (RFr1e/RFr2e) bật, xuất dữ liệu. 
    // Nếu không, xuất toàn số 0. Dùng lệnh assign để dữ liệu ra tức thời.
    
    assign RFr1 = (RFr1e) ? rf[RFr1a] : {DATA_WIDTH{1'b0}};
    assign RFr2 = (RFr2e) ? rf[RFr2a] : {DATA_WIDTH{1'b0}};

endmodule

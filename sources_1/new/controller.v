`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/08/2026 04:17:33 PM
// Design Name: 
// Module Name: controller
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


module controller(
    input wire clk,
    input wire rst,
    
    input  wire [6:0] IR_opcode,
    output reg mar_sel,
    output reg mar_ld,
    output reg [1:0] mbr_sel,
    output reg mbr_ld,
    output reg [2:0] ALUop,
    output reg Mre,
    output reg Mwe,
    output reg IR_ld,
    output reg PC_inc,
    output reg PCclr,
    output reg RFwe,
    output reg RFr1e,
    output reg RFr2e,
    output reg oprB_sel,
    input  wire isZ,
    input wire zFlag,
    output reg CCR_we,
    output reg PCld
    );
    
    localparam [1:0]
                SPEC_OP = 2'b00,
                DATA_TRANS = 2'b01,
                DATA_PROC = 2'b10,
                FLOW_CTRL = 2'b11;
    localparam [4:0]
        LDR = 5'b00001,
        MOV = 5'b00000,
        STR = 5'b00010;
    localparam [4:0]
        STOP = 5'b00000,
        NOP  = 5'b00001;
    localparam [4:0]
        ADD = 5'b00000,
        ADDL = 5'b00001,
        SUB = 5'b00010,
        AND = 5'b00011,
        OR = 5'b00100,
        NOT = 5'b00101;
    localparam [4:0]
        CMP = 5'b00000,
        CMPL = 5'b00001,
        BEQ = 5'b00011,
        BRA = 5'b00010,
        BNE = 5'b00100;
        
    localparam
    s1  = 0,
    s1a = 1,
    s1b = 2,
    s1c = 3,
    s2  = 4,
    TRANS_ENC  = 5,
    s4  = 6,
    s4a = 7,
    s4b = 8,
    s5  = 9,
    s5a = 10,
    s6  = 11,
    s6a = 12,
    s7 = 13,
    s8 = 14,
    s9 = 15,
    s10 = 16,
    s11 = 17,
    s11a = 18,
    s12 = 19,
    s13 = 20,
    s14 = 21,
    s15 = 22,
    s16 = 23,
    s17 = 24,
    s17a = 25,
    s18 = 26,
    FLOW_ENC = 27,
    PROC_ENC = 28,
    HALT = 29,
    SPEC_ENC = 30,
    s0  = 31;
    reg [4:0] state_reg, state_next;
    
    //state register
    always @(posedge clk, posedge rst)
        if (rst)
            state_reg <= s0;
        else
            state_reg <= state_next;
    
    always @* begin
        state_next = state_reg; //default
        mar_sel = 1'b0;
        mar_ld = 1'b0;
        mbr_sel = 2'b00;
        mbr_ld = 1'b0;
        ALUop = 3'b000;
        Mre = 1'b0;
        Mwe = 1'b0;
        IR_ld = 1'b0;
        PC_inc = 1'b0;
        PCclr = 1'b0;
        RFwe = 1'b0;
        RFr1e = 1'b0;
        RFr2e = 1'b0;
        oprB_sel = 1'b0;
        CCR_we = 1'b0;
        PCld   = 1'b0;
        
        case (state_reg)
            s0: begin
                PCclr = 1'b1;
                state_next = s1;
            end
            s1: begin
                mar_sel = 1'b0;
                mar_ld  = 1'b1;
                state_next = s1a;
                end
            s1a: begin
                mbr_sel = 2'b01;
                Mre = 1'b1;
                mbr_ld = 1'b1;
                state_next = s1b;
                end
            s1b: begin
                
                IR_ld = 1'b1;
                PC_inc = 1'b1;
                state_next = s1c;
                end
            s1c: begin
                PC_inc = 1'b0;
                state_next = s2;
                end
            s2: begin
                
                case (IR_opcode[6:5])
                    DATA_TRANS: begin
                        state_next = TRANS_ENC;
                        end
                    SPEC_OP: begin
                        state_next = SPEC_ENC;
                    end
                    DATA_PROC: begin
                        state_next = PROC_ENC;
                    end
                    FLOW_CTRL: begin
                        state_next = FLOW_ENC;
                    end
                    default: state_next = s1;
                endcase
                end
            TRANS_ENC: begin
                case (IR_opcode[4:0])
                    LDR: begin
                        state_next = s4;
                        end
                    MOV: begin
                        state_next = s5;
                    end
                    STR: begin
                        state_next = s6;
                    end
                    default: state_next = s1;
                endcase       
            end
            PROC_ENC: begin
                case (IR_opcode[4:0])
                    ADD: begin
                        state_next = s7;
                        end
                    ADDL: begin
                        state_next = s11;
                    end
                    SUB: begin
                        state_next = s8;
                    end
                    AND: begin
                        state_next = s12;
                    end
                    OR: begin
                        state_next = s13;
                    end
                    NOT: begin
                        state_next = s14;
                    end
                    default: state_next = s1;
                endcase 
            end
            FLOW_ENC: begin
                case (IR_opcode[4:0])
                    CMP: begin
                        state_next = s9;
                        end
                    CMPL: begin
                        state_next = s17;
                    end
                    BEQ: begin
                        state_next = s10;
                    end
                    BNE: begin
                        state_next = s15;
                    end
                    BRA: begin
                        state_next = s16;
                    end
                    default: state_next = s1;
                endcase 
            end
            SPEC_ENC: begin
                case (IR_opcode[4:0])
                    STOP: begin
                        state_next = HALT;
                    end
                    NOP: begin
                        state_next = s18;
                    end
                    default: state_next = s1;
                endcase
            end
            s4: begin
                mar_sel = 1'b1;
                mar_ld  = 1'b1;
                state_next = s4a;
            end
            s4a: begin
                Mre = 1'b1;
                mbr_sel = 2'b01;
                mbr_ld = 1'b1;
                state_next = s4b;
            end 
            s4b: begin
                oprB_sel = 1'b0;
                ALUop = 3'b101;
                RFwe = 1'b1;
                state_next = s1;
            end
            s5: begin
                RFr1e = 1'b1;
                ALUop = 3'b110;
                RFwe = 1'b1;
                state_next = s1;
            end
            s6: begin
                mar_sel = 1'b1;
                mar_ld = 1'b1;
                RFr1e = 1'b1;
                ALUop = 3'b110;
                mbr_sel = 1'b0;
                mbr_ld = 1'b1;
                state_next = s6a;
            end
            s6a: begin
                Mwe = 1'b1;
                state_next = s1;
            end
            s7: begin
                RFr1e = 1'b1;
                RFr2e = 1'b1;
                oprB_sel = 1'b1;
                ALUop = 3'b000;
                RFwe = 1'b1;
                state_next = s1;
            end
            s8: begin
                RFr1e = 1'b1;
                RFr2e = 1'b1;
                oprB_sel = 1'b1;
                ALUop = 3'b001;
                RFwe = 1'b1;
                state_next = s1;
            end
            s9: begin
                RFr1e = 1'b1;
                RFr2e = 1'b1;
                oprB_sel = 1'b1;
                ALUop = 3'b001;
                CCR_we = isZ;
                state_next = s1;
            end
            s10: begin
                CCR_we = 1'b1;
                if (zFlag == 1'b1) begin
                    PCld = 1'b1;
                    state_next = s1;
                end
                else begin
                    state_next = s1;
                end
            end
            s11: begin
                mbr_sel = 2'b10;
                mbr_ld = 1'b1;
                state_next = s11a;
            end
            s11a: begin
                RFr1e = 1'b1;
                oprB_sel = 1'b0;
                ALUop = 3'b000;
                RFwe = 1'b1;
                state_next = s1;
            end
            s12: begin
                RFr1e = 1'b1;
                RFr2e = 1'b1;
                oprB_sel = 1'b1;
                ALUop = 3'b010;
                RFwe = 1'b1;
                state_next = s1;
            end
            s13: begin
                RFr1e = 1'b1;
                RFr2e = 1'b1;
                oprB_sel = 1'b1;
                ALUop = 3'b011;
                RFwe = 1'b1;
                state_next = s1;
            end
            s14: begin
                RFr1e = 1'b1;
                RFr2e = 1'b1;
                oprB_sel = 1'b1;
                ALUop = 3'b100;
                RFwe = 1'b1;
                state_next = s1;
            end
            s15: begin
                CCR_we = 1'b1;
                if (zFlag == 1'b0) begin
                    PCld = 1'b1;
                    state_next = s1;
                end
                else begin
                    state_next = s1;
                end
            end
            s16: begin
                    CCR_we = 1'b1;
                    PCld = 1'b1;
                    state_next = s1;
            end
            s17: begin
                mbr_sel = 2'b10;
                mbr_ld = 1'b1;
                state_next = s17a;
            end
            s17a: begin
                RFr1e = 1'b1;
                oprB_sel = 1'b0;
                ALUop = 3'b001;
                CCR_we = isZ;
                state_next = s1;
            end
            s18: begin
                state_next = s1;
            end
            HALT: begin
                state_next = HALT;
            end
            
            default: state_next = s0;
        endcase
    end
endmodule

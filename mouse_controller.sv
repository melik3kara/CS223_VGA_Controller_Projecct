`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2024 02:37:06 PM
// Design Name: 
// Module Name: mouse_controller
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


module mouse_controller #(parameter MAX_X = 639, parameter MAX_Y = 479) (
    input logic mouse_clk,
    input logic mouse_data,
    input logic clk,
    input logic reset,
    output logic [9:0] mouseX,
    output logic [9:0] mouseY,
    output logic mouseLeftButton,
    output logic mouseRightButton);
    //right button is not used it is here just for standartise purpose
    `define clamped_plus(coord, minus, mag, max) \
        minus ? ((coord < mag) ? 0 : (coord - mag)) \
              : ((coord + mag > max) ? max : (coord + mag))
    
    logic [43:0] pckt;
    logic [1:0] mouse_clk_hist;
    logic [5:0] bits_of_packet;
    
    logic signed [8:0] xDelta, yDelta;
    logic [9:0] xDeltaMag, yDeltaMag;
    logic xDeltaSign, yDeltaSign;
    logic xOverflow, yOverflow;
    //These flags indicate if the movement exceeds the range 
    //that can be represented by the 8-bit signed delta values (xDelta and yDelta).
   
    //packet assigns
    assign xDelta = { pckt[38], pckt[24], pckt[25], pckt[26], pckt[27], pckt[28], pckt[29], pckt[30], pckt[31] };
    assign yDelta = { pckt[37], pckt[13], pckt[14], pckt[15], pckt[16], pckt[17], pckt[18], pckt[19], pckt[20] };
    assign { xOverflow, yOverflow } = pckt[36:35];
    //comparison logic
    assign xDeltaSign = xDelta < 0;
    assign yDeltaSign = yDelta > 0;
    assign xDeltaMag = xDelta < 0 ? (-xDelta) : xDelta;
    assign yDeltaMag = yDelta < 0 ? (-yDelta) : yDelta;
    
    initial begin
        mouse_clk_hist <= 2'b11;
    end
    //the logic starts
    always_ff @(posedge clk or posedge reset) 
    begin
        if (reset) //if reset is on
        begin
        
            bits_of_packet <= 0;
            pckt <= 0;
            mouse_clk_hist <= 2'b11;
            mouseX <= MAX_X / 2;
            mouseY <= MAX_Y / 2;
            mouseLeftButton <= 1'b0;
            mouseRightButton <= 1'b0;//unused but is is here to be standadize
        end
        else 
        begin
            mouse_clk_hist <= { mouse_clk_hist[0], mouse_clk };
            if (mouse_clk_hist == 2'b10) begin
            
                pckt <= { pckt[42:0], mouse_data };
                bits_of_packet <= bits_of_packet + 1;
                
            end
            else if (bits_of_packet == 44) 
            begin
            
                mouseLeftButton <= pckt[42];
                mouseRightButton <= pckt[41];
                // clamped_plus ensures coordinate updates respect screen boundaries.
                mouseX <= `clamped_plus(mouseX, xDeltaSign, xDeltaMag, MAX_X);
                mouseY <= `clamped_plus(mouseY, yDeltaSign, yDeltaMag, MAX_Y);
 
                pckt <= 0;
                bits_of_packet <= 0;
            end
        end
    end
    
endmodule

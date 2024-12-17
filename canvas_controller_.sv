`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2024 03:25:15 PM
// Design Name: 
// Module Name: canvas_controller_
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


module canvas_controller_#
(                           parameter int color_palette_bit = 2,
                            parameter logic [8*(1 << color_palette_bit)-1:0] color_choices = -1,
                            parameter int width = 100,
                            parameter int height = 100
                            ) (
    //input logics
    input logic clk,
    input logic xyvalid,
    input logic [9:0] x,
    input logic [9:0] y,
    input logic [9:0] writeX,
    input logic [9:0] writeY,
    input logic write_enable, //enable
    input logic [color_palette_bit-1:0] write_color,
    //output logics
    output logic [2:0] red,
    output logic [2:0] green,
    output logic [1:0] blue
    );
    
    logic [color_palette_bit-1:0] color_palletes;
    
    RAM_controller #(
        .width_of_ram(color_palette_bit), 
        .depth_of_ram(width * height)
    ) 
    ram (
        .write_addr(writeX + writeY * width),
        .read_addr(x + y * width),
        .word_in(write_color),
        .clk(clk),
        .write_en(write_enable),
        .read_en(xyvalid),
        .output_rst(0),
        .output_en(1),
        .word_out(color_palletes));
    //assigning the color bits from volor luts respect to xyvalid
    assign red   = xyvalid ? color_choices[8 * color_palletes + 7 -: 3] : 0;
    assign green = xyvalid ? color_choices[8 * color_palletes + 4 -: 3] : 0;
    assign blue  = xyvalid ? color_choices[8 * color_palletes + 1 -: 2] : 0;
    
endmodule

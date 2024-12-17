`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/11/2024 10:20:16 PM
// Design Name: 
// Module Name: buttonController
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


module buttonController #(
    parameter int boundiries_X = 639,
    parameter int boundiries_Y = 479
)(
    input  logic clk,
    input  logic reset,
    //button inputs
    input  logic right_btn,
    input  logic left_btn,
    input  logic up_btn,
    input  logic down_btn,
    input  logic center_btn,
    //mouse inputs
    output logic [9:0] mouseX,
    output logic [9:0] mouseY,
    output logic pixel_will_painted
);

    logic [19:0] counter; 
    //slwowing down with counter for movements
    logic enable;

    initial begin
        mouseX = boundiries_X / 2;
        mouseY = boundiries_Y / 2;
        pixel_will_painted = 0;
        counter = 0;
    end
    //initially cursor will born in the middle of the screen

     //logic beginds
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 0;
            enable <= 0;
        end else begin
            counter <= counter + 1;
            if (counter == 0) 
            //eneable is triggerde due to counter made over floe
                enable <= 1;
            else //else case anable is 0
                enable <= 0;
        end
    end

    //cursor movement logic begins here
    always_ff @(posedge clk or posedge reset) begin
    //reset both resets mouuse movement and pixel drawing
        if (reset) begin
            mouseX <= boundiries_X / 2;
            mouseY <= boundiries_Y / 2;
            pixel_will_painted <= 0;
        end else begin
        //movement logic starts
            if (enable) begin
                if (right_btn)//logic for right button
                    mouseX <= (mouseX < boundiries_X) ? mouseX + 1 : boundiries_X;
                if (left_btn)//logic for left button
                    mouseX <= (mouseX > 0) ? mouseX - 1 : 0;
                if (up_btn)//logic for up button
                    mouseY <= (mouseY > 0) ? mouseY - 1 : 0;
                if (down_btn)//logic for down button
                    mouseY <= (mouseY < boundiries_Y) ? mouseY + 1 : boundiries_Y;

            end
            if (center_btn)//center button logic is not bothered from others
                pixel_will_painted <= 1;
            else
                pixel_will_painted <= 0;
        end
    end

endmodule
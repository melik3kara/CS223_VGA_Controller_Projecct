`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2024 03:30:05 PM
// Design Name: 
// Module Name: project_main
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


module project_main(
    //button inputs
    /*input logic up_btn,
    input logic down_btn,
    input logic left_btn,
    input logic right_btn,
    input logic center_btn,*/
    
    //if you want to usae buttons instead mouse use this variables
    
    //mouse inputs
    input logic mouse_clk,
    input logic mouse_data,
    //Clock
    input logic clk_100MHz,
  
    input logic brushController,
    input logic [8:0] sw, 
    //9-bit vga color
    output logic [2:0] vgaRed,
    output logic [2:0] vgaGreen,
    output logic [1:0] vgaBlue,//blue is 2 bit
    output logic vgaHsync,
    output logic vgaVsync
);
    //brush logics
    logic [9:0] brushSize = 1;  
    logic [3:0] brushColor = 4'b0000; 
    //mouse logics
    logic [9:0] mouseX, mouseY;
    logic mouseLeftButton;
    logic mouseRightButton;
    logic [9:0] cursor_logic_mouse_X, cursor_logic_mouse_Y;
    
    logic [9:0] addPixelX, addPixelY;
    logic reset = 0;
    logic clk_25MHz;
    logic xyvalid;
    logic yvalid;
    
    logic [9:0] pixelX, pixelY;
    
    logic isClearing = sw[8];//it was created for debugging purposes, it is n 
    
    always_ff @(posedge clk_100MHz) begin
        if (xyvalid) begin
            cursor_logic_mouse_X <= mouseX;
            cursor_logic_mouse_Y <= mouseY;
        end
    end
    //mouse logic
    mouse_controller mouse_controller(
        .clk(clk_100MHz),
        .reset(reset),
        .mouse_clk(mouse_clk),
        .mouse_data(mouse_data),
        .mouseX(mouseX),
        .mouseY(mouseY),
        .mouseLeftButton(mouseLeftButton),
        .mouseRightButton(mouseRightButton)
    );
    //button logic
    /*buttonController buttonController(
            .clk(clk_100MHz),
            .reset(reset),
            .up_btn(up_btn),
            .down_btn(down_btn),
            .left_btn(left_btn),
            .right_btn(right_btn),
            .center_btn(center_btn),
            .mouseX(mouseX),
            .mouseY(mouseY),
            .pixel_will_painted(mouseLeftButton)
        );*/
    //if you want to control with buttons instead mous use this
    logic canvasActive;
    assign canvasActive = xyvalid;
    logic [7:0] canvasColor;

    // cursor logic
    logic active_pointer1 = cursor_logic_mouse_X <= pixelX && pixelX < cursor_logic_mouse_X + 1 &&
                           cursor_logic_mouse_Y <= pixelY && pixelY < cursor_logic_mouse_Y + 5; // Downward line
    logic active_pointer2 = cursor_logic_mouse_X <= pixelX && pixelX < cursor_logic_mouse_X + 5 &&
                           cursor_logic_mouse_Y <= pixelY && pixelY < cursor_logic_mouse_Y + 1;  // Rightward line
    logic active_pointer3 = cursor_logic_mouse_X - 5 <= pixelX && pixelX < cursor_logic_mouse_X &&
                           cursor_logic_mouse_Y <= pixelY && pixelY < cursor_logic_mouse_Y + 1;  // Leftward line
    logic active_pointer4 = cursor_logic_mouse_X <= pixelX && pixelX < cursor_logic_mouse_X + 1 &&
                           cursor_logic_mouse_Y - 5 <= pixelY && pixelY < cursor_logic_mouse_Y; // Upward line

    logic [7:0] pointerColor;

    localparam COLOUR_0 = 8'b111_111_11;  
    localparam COLOUR_1 = 8'b000_111_00;  
    localparam COLOUR_2 = 8'b000_000_11;  
    localparam COLOUR_3 = 8'b111_111_00;  
    localparam COLOUR_4 = 8'b111_000_11;  
    localparam COLOUR_5 = 8'b000_111_11;  
    localparam COLOUR_6 = 8'b011_011_10;  
    localparam COLOUR_7 = 8'b111_000_00;  
    localparam COLOUR_8 = 8'b000_000_00;  


    canvas_controller_ #(
        .color_palette_bit(3),
        .color_choices({COLOUR_8, COLOUR_7, COLOUR_6, COLOUR_5, COLOUR_4, COLOUR_3, COLOUR_2, COLOUR_1, COLOUR_0}),
        .width(640),
        .height(480)
    ) 
    canvas(
        .clk(clk_100MHz),
        .xyvalid(canvasActive),
        .x(pixelX),
        .y(pixelY),
        .writeX(isClearing ? pixelX : mouseX + addPixelX),
        .writeY(isClearing ? pixelY : mouseY + addPixelY),
        .write_enable(isClearing || (mouseLeftButton && (mouseX + addPixelX < 640) && brushColor != 0)),
        .write_color(isClearing ? 0 : brushColor),
        .red(canvasColor[7:5]),
        .green(canvasColor[4:2]),
        .blue(canvasColor[1:0]));
    //brush size logic
    always_ff @(posedge clk_100MHz) begin
        case (brushController) 
            1'b0: brushSize <= 1;
            1'b1: brushSize <= 3;
            default: brushSize <= 1; 
        endcase

        case (sw[7:0])  
            8'b00000001: brushColor <= 1;  
            8'b00000010: brushColor <= 2;  
            8'b00000100: brushColor <= 3;  
            8'b00001000: brushColor <= 4;  
            8'b00010000: brushColor <= 5;  
            8'b00100000: brushColor <= 6;  
            8'b01000000: brushColor <= 7;  
            8'b10000000: brushColor <= 8;  
            default: brushColor <= 0; 
        endcase
    end

    
    assign pointerColor = 8'h000;

    //vga color logic to show the cursor
    assign vgaRed = (active_pointer1 || active_pointer2 || active_pointer3 || active_pointer4) ? pointerColor[7:5] : canvasColor[7:5];
    assign vgaGreen = (active_pointer1 || active_pointer2 || active_pointer3 || active_pointer4) ? pointerColor[4:2] : canvasColor[4:2];
    assign vgaBlue = (active_pointer1 || active_pointer2 || active_pointer3 || active_pointer4) ? pointerColor[1:0] : canvasColor[1:0];

    clock_divider #(.factor_div(4)) vgaPixelClkDiv(
        .clk(clk_100MHz),
        .reset(0),
        .clock_divided(clk_25MHz));

    vga_controller vga_controller(
        .clk(clk_100MHz),
        .clk_25MHz(clk_25MHz),
        .clr(0),
        .horizontal_sync(vgaHsync),
        .vertical_sync(vgaVsync),
        .xyvalid(xyvalid),
        .yvalid(yvalid),
        .x(pixelX),
        .y(pixelY));

    cursor_scanner #(.x_bits(10), .y_bits(10)) cursor_scanner (
        .clk(clk_100MHz),
        .enable(clk_25MHz),
        .x(addPixelX),
        .y(addPixelY),
        .width(brushSize), 
        .height(brushSize) );

endmodule

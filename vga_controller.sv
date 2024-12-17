`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2024 02:57:03 PM
// Design Name: 
// Module Name: vga_controller
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


module vga_controller(
    input logic clk,       
	input logic clk_25MHz, 
	input logic clr,  
    output logic xyvalid,
    output logic yvalid,     
	output logic horizontal_sync,    
	output logic vertical_sync,    
	output logic [9:0] x,  
	output logic [9:0] y  );
    //parameters written from the project file
    parameter int horizontal_back_porch = 144;     
    parameter int horizontal_front_porch = 784;     
    parameter int vertical_back_porch = 0;      
    parameter int vertical_front_porch = 480;  
    parameter int horizantal_pixels = 800; 
    parameter int vertical_lines = 480;  
    parameter int horizantal_pulse = 96;   
    parameter int vertical_pulse = 2;       

    logic [9:0] horizontal_cync;
    logic [9:0] vertical_cync;
    //logic starts
   always_ff @(posedge clk or posedge clr) begin
            if (clr) //clr currently is not used it was here for debugging purposes
            begin
                horizontal_cync <= 0;
                vertical_cync <= 0;
            end else if (clk_25MHz) 
            begin
                if (horizontal_cync < horizantal_pixels - 1) //checking for boundries
                begin
                    horizontal_cync <= horizontal_cync + 1;
                end else 
                begin
                    horizontal_cync <= 0;
                    if (vertical_cync < vertical_lines - 1) //checking for boundries
                    begin
                        vertical_cync <= vertical_cync + 1;
                    end else 
                    begin
                        vertical_cync <= 0;
                    end
                end
            end
        end
    //assignments starts here to proporley assigning the screen boundirais
    assign horizontal_sync = (horizontal_cync < horizantal_pulse) ? 1'b0 : 1'b1;
    assign vertical_sync = (vertical_cync < vertical_pulse) ? 1'b0 : 1'b1;
    assign xyvalid = (vertical_back_porch <= vertical_cync && vertical_cync < vertical_front_porch && horizontal_back_porch <= horizontal_cync && horizontal_cync < horizontal_front_porch);
    assign yvalid  = (vertical_cync < vertical_front_porch);
    /*assign x       = horizontal_cync;
    assign y       = vertical_cync;*/
    assign x       = horizontal_cync - horizontal_back_porch;
    assign y       = vertical_cync - vertical_back_porch;
    
endmodule

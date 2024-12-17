`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2024 02:47:30 PM
// Design Name: 
// Module Name: cursor_scanner
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


module cursor_scanner #(parameter x_bits = 3, parameter y_bits = 3)
(
   input logic [x_bits+1-1:0] width,
   input logic  [y_bits+1-1:0] height,
   input logic clk, //clock
   input logic enable, //enable for cursor always able
   output logic [x_bits-1:0] x,
   output logic [y_bits-1:0] y);
   
   //logic starts here
   always_ff @(posedge clk) 
   begin
       if (enable) begin
            if (x < width - 1) 
            begin
                      x <= x + 1;   
           end
           else 
           begin
               x <= 0;              
               if (y < height - 1) 
               begin
                    y <= y + 1;          
               end else 
               begin
                    y <= 0;            
               end
           end
       end
   end
   
endmodule
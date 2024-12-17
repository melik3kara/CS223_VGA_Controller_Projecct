`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2024 03:06:25 PM
// Design Name: 
// Module Name: clock_divider
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


module clock_divider#(
    parameter factor_div = 1
) (
    input logic clk,
    input logic reset,
    output logic clock_divided);
     // Counter with the required number of bits to represent factor_div
    logic [$clog2(factor_div)-1:0] counter;
    
     // Assign divided clock signal
    assign clock_divided = (counter == (factor_div - 1));
    
    //logic starts
     always_ff @(posedge clk or posedge reset) 
     begin
           if (reset) // if the reset 1
           begin
               counter <= 0;
           end else if (counter == (factor_div - 1)) //counter check
           begin
               counter <= 0;
           end else 
           begin
               counter <= counter + 1;
           end
       end
   endmodule
# CS223 Term Project: VGA Driver and Drawing Canvas

## Project Overview
This project implements a **Video Graphics Array (VGA) controller** and a **drawing canvas application** using the Basys 3 FPGA board and SystemVerilog. The design enables users to interact with a canvas, draw using buttons or a PS/2 mouse, and customize brush size and color.

The project is organized into **three main stages**:
1. **VGA Controller**: Implements the timing and synchronization signals for a 640x480 display.
2. **Drawing Canvas Application**: Creates an interactive canvas where users can draw with a controllable cursor and customizable colors.
3. **PS/2 Mouse Integration**: Enables drawing and cursor control via a PS/2 mouse.

---

## Project Features

1. **VGA Controller**
   - Resolution: **640 x 480 pixels**
   - Frame Rate: **60 Hz**
   - **Synchronization Signals**: Generates HSYNC and VSYNC for timing control.
   - Supports a scrolling checkerboard test pattern.

2. **Drawing Canvas Application**
   - **Cursor Control**: A `+`-shaped cursor controlled using buttons or the PS/2 mouse.
   - **Color Selection**:
     - 8 selectable colors controlled via switches.
   - **Brush Size**:
     - **1x1** pixel brush (small).
     - **3x3** brush for larger strokes.
   - **Canvas Initialization**: Starts with a white canvas, allowing users to interactively update pixels.

3. **PS/2 Mouse Integration**
   - Cursor movement controlled by mouse signals.
   - Drawing enabled via the **left-click button**.

---

## Project Structure

The project consists of multiple SystemVerilog modules:

| **Module Name**       | **Description**                                                                 |
|------------------------|-------------------------------------------------------------------------------|
| `project_main`        | Top-level module integrating all submodules (VGA controller, mouse, canvas).   |
| `vga_controller`      | Generates HSYNC and VSYNC signals for VGA display operation.                  |
| `canvas_controller`   | Manages pixel colors on the canvas based on input coordinates.                |
| `mouse_controller`    | Reads mouse input (X, Y coordinates and button states) via PS/2 interface.    |
| `cursor_scanner`      | Handles grid scanning for the cursor movement and boundary logic.             |
| `RAM_controller`      | Implements BRAM (Block RAM) for storing pixel data.                           |
| `clock_divider`       | Divides the input clock to generate the VGA-compatible **25 MHz pixel clock**. |
| `buttonController`    | Optional module for button-based cursor movement and pixel drawing.           |

---

## System Requirements

To run this project successfully, you need:

- **Vivado Design Suite** (for synthesis, simulation, and bitstream generation)
- **Basys 3 FPGA Board**
- **Monitor**: VGA-compatible display
- **Wired PS/2 Mouse**
- **Peripherals**: Buttons and switches on the Basys 3 board

---

## How to Run the Project

1. **Setup**:
   - Connect the Basys 3 FPGA board to the computer.
   - Attach a **VGA-compatible monitor** to the board using a VGA cable.
   - Connect a **PS/2 mouse** for cursor control.

2. **Synthesis and Programming**:
   - Open **Vivado** and load all the SystemVerilog files provided.
   - Synthesize and implement the project.
   - Generate the bitstream and program the Basys 3 board.

3. **Running the Application**:
   - **Stage 1**: Verify the checkerboard test pattern on the monitor. Use directional buttons to scroll the display.
   - **Stage 2**: Use directional buttons or the PS/2 mouse to move the cursor. Select a brush color using switches and draw on the canvas by pressing the center button (for buttons) or mouse left-click.
   - **Stage 3**: Control the cursor position and draw seamlessly using the PS/2 mouse.

---

## Inputs and Outputs

- **Inputs**:
  - Directional buttons: Cursor movement.
  - Switches: Color selection (8 colors) and brush size control.
  - PS/2 Mouse: Cursor movement and left-click for drawing.

- **Outputs**:
  - VGA display: Real-time updates of the interactive canvas.
  - Visual cursor and brush strokes on the monitor.

---

## Testing and Verification

- Verify VGA timing using the **checkerboard test pattern**.
- Test directional button-based cursor movement.
- Verify PS/2 mouse functionality (cursor control and drawing).
- Test all brush sizes and colors using the switches.

---

## File Descriptions

- **Modules**:
   - `project_main.sv`: Top-level module.
   - `vga_controller.sv`: VGA signal generation.
   - `canvas_controller.sv`: Pixel management for canvas drawing.
   - `mouse_controller.sv`: Handles PS/2 mouse input.
   - Helper Modules: `clock_divider`, `RAM_controller`, `cursor_scanner`, `buttonController`.

- **Report**:
   - Detailed design explanations, block diagrams, RTL schematics, and state machines.

---

## Author

- **Name**: Melike Kara  

---


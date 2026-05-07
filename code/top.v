
`timescale 1ns / 1ps

module top (
    output wire [7:0] ROW,
    output wire [7:0] COL,

    input wire btn_R,
    input wire btn_L,
    input wire btn_U,
    input wire btn_D,

    input wire clk,
    input wire rst
);
    wire [1:0] dir;
    wire [63:0] snake_flat;
    
    direction_maker direction_maker (
        .dir(dir),
        .R(btn_R), 
        .L(btn_L), 
        .U(btn_U), 
        .D(btn_D),
		.clk(clk),
		.rst(rst)
    );

    snake #(.CLK_DIV(33554431)) snake(
        .snake_flat(snake_flat), 
        .direction(dir),
        .clk(clk),
        .rst(rst)
    );

    dotmatrix_interface #(.count_to(2000)) u_dot (
        .clk        (clk),
        .rst        (rst),
        .shape_flat (snake_flat),
        .R          (ROW),
        .C          (COL)
    );

endmodule

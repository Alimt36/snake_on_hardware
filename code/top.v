
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
    wire game_run ;
    wire [6:0] snake_length ;
    reg  [3:0] ones ;
    reg  [3:0] tens ;
    wire [7:0] ascii_out ;
    wire [63:0] shape_muxed_out ;
    wire [63:0] font_flat ;

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
        .game_run(game_run),
        .snake_length(snake_length),
        .direction(dir),
        .clk(clk),
        .rst(rst)
    );

    dotmatrix_interface #(.count_to(2000)) u_dot (
        .clk        (clk),
        .rst        (rst),
        .shape_flat (shape_muxed_out),
        .R          (ROW),
        .C          (COL)
    );

    always @(posedge clk) begin

        if (~game_run) begin
            if (snake_length - 3 < 10) begin
                tens <= 0 ;
                ones <= snake_length - 3 ;
            end
            else begin 
                tens <= snake_length / 10       ;
                ones <= (snake_length % 10) - 3 ;
            end
        end
        else begin 
            tens <= 0 ;
            ones <= 0 ;
        end
    end

    sequencer #(.count_to(18000000)) seq (
        .ascii_out(ascii_out),
        .tens(tens) ,
        .ones(ones) ,
        .rst(rst),
        .clk(clk)
    );
  
    font_holder f_h (

    .shape_flat(font_flat) ,

    .hopefully_ascii_input(ascii_out) 

    );

    assign shape_muxed_out = ( tens == 0 && ones == 0 ) ? snake_flat : font_flat ;

endmodule

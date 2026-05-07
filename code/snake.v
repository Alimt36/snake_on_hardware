
`timescale 1ns / 1ps

module snake #(
    parameter CLK_DIV = 2000
)(
    output reg [63:0] snake_flat,
    input [1:0] direction,
    input wire clk,
    input wire rst
);

    reg [2:0] position [63:0][1:0];
    reg [6:0] snake_length;
    integer i, j;
    reg [$clog2(CLK_DIV+1)-1:0] counter;
    reg [1:0] dir;
    reg game_run;
    reg [5:0] food_position;
    reg food_positioned;
    reg food_eaten;          
    reg [2:0] last_tail_X;
    reg [2:0] last_tail_Y;
    wire [5:0] food_position_next = {(food_position[0] ^ food_position[1]), food_position[5:1]};
//---------------------------------------------------------------------------------------------------------------------------
// death_check Function
//---------------------------------------------------------------------------------------------------------------------------
    function death_check;
        input [1:0] dir;
        input [2:0] head_X;
        input [2:0] head_Y;
        input [63:0] snake_flat;
        input [5:0] food_position;
        input [2:0] tail_X;       
        input [2:0] tail_Y;       
    
        reg [6:0] temp;
        reg [5:0] tail_flat;
    
    begin
        tail_flat = tail_Y * 8 + tail_X;  
    
        case (dir)
            2'b00 : begin
                if (head_Y == 7) death_check = 1'b0;
                else             death_check = 1'b1;
            end
            2'b01 : begin
                if (head_X == 7) death_check = 1'b0;
                else             death_check = 1'b1;
            end
            2'b10 : begin
                if (head_Y == 0) death_check = 1'b0;
                else             death_check = 1'b1;
            end
            2'b11 : begin
                if (head_X == 0) death_check = 1'b0;
                else             death_check = 1'b1;
            end
            default : death_check = 1'b1;
        endcase
    
        if (death_check) begin
            case (dir)
                2'b00 : begin
                    temp = head_X * 8 + (head_Y + 1);
                    if ((snake_flat[temp] == 1'b1) && (temp != food_position) && (temp != tail_flat))
                        death_check = 1'b0;
                    else
                        death_check = 1'b1;
                end
                2'b01 : begin
                    temp = (head_X + 1) * 8 + head_Y;
                    if ((snake_flat[temp] == 1'b1) && (temp != food_position) && (temp != tail_flat))
                        death_check = 1'b0;
                    else
                        death_check = 1'b1;
                end
                2'b10 : begin
                    temp = head_X * 8 + (head_Y - 1);
                    if ((snake_flat[temp] == 1'b1) && (temp != food_position) && (temp != tail_flat))
                        death_check = 1'b0;
                    else
                        death_check = 1'b1;
                end
                2'b11 : begin
                    temp = (head_X - 1) * 8 + head_Y;
                    if ((snake_flat[temp] == 1'b1) && (temp != food_position) && (temp != tail_flat))
                        death_check = 1'b0;
                    else
                        death_check = 1'b1;
                end
                default : death_check = 1'b1;
            endcase
        end
    end
    endfunction
//---------------------------------------------------------------------------------------------------------------------------
// Clock divider (parameterized)
//---------------------------------------------------------------------------------------------------------------------------
    always @ (posedge clk or posedge rst) begin
        if (rst == 1'b1) begin
            counter <= 0;
        end
        else begin
            if (counter == CLK_DIV) counter <= 0;
            else                    counter <= counter + 1;
        end
    end

//---------------------------------------------------------------------------------------------------------------------------
// Captures direction input into reg dir
//---------------------------------------------------------------------------------------------------------------------------
    always @ (direction) begin
        dir <= direction;
    end

//---------------------------------------------------------------------------------------------------------------------------
// Movement always block
//---------------------------------------------------------------------------------------------------------------------------
    always @ (posedge clk or posedge rst) begin
        if (rst == 1'b1) begin
            game_run     <= 1'b1;
            snake_length <= 7'd3;
            food_eaten   <= 1'b0;

            for (i = 0; i < 64; i = i + 1) begin
                for (j = 0; j < 2; j = j + 1) begin
                    position[i][j] <= 3'b000;
                end
            end

            position[0][0] <= 3'd3;
            position[0][1] <= 3'd3;
            position[1][0] <= 3'd2;
            position[1][1] <= 3'd3;
            position[2][0] <= 3'd1;
            position[2][1] <= 3'd3;
        end
        else begin
            food_eaten <= 1'b0; 

            if (counter == CLK_DIV) begin
                //game_run <= death_check(dir, position[0][1], position[0][0], snake_flat, food_position);

                if (game_run) begin
                    //game_run <= death_check(dir, position[0][1], position[0][0], snake_flat, food_position);
                    game_run <= death_check( dir, position[0][1], position[0][0], snake_flat, food_position, position[snake_length-1][1], position[snake_length-1][0] );
                    position[snake_length][0] <= last_tail_X;
                    position[snake_length][1] <= last_tail_Y;

                    for (i = 63; i > 0; i = i - 1) begin
                        for (j = 0; j < 2; j = j + 1) begin
                            position[i][j] <= position[i-1][j];
                        end
                    end

                    case (dir)
                        2'b00 :  position[0][0] <= position[0][0] + 3'd1;
                        2'b01 :  position[0][1] <= position[0][1] + 3'd1;
                        2'b10 :  position[0][0] <= position[0][0] - 3'd1;
                        2'b11 :  position[0][1] <= position[0][1] - 3'd1;
                        default: position[0][0] <= position[0][0] + 3'd1;
                    endcase

                    if (((position[0][1] * 8 + position[0][0]) == food_position) && food_positioned) begin
                        snake_length <= snake_length + 1'd1;
                        food_eaten   <= 1'b1;  
                    end

                    last_tail_Y <= position[snake_length-1][0];
                    last_tail_X <= position[snake_length-1][1];
                end
            end
        end
    end

//---------------------------------------------------------------------------------------------------------------------------
// Output mapping
//---------------------------------------------------------------------------------------------------------------------------
    always @ (posedge clk) begin
        if (~game_run) begin
            snake_flat <= 64'b0;
        end
        else begin
            snake_flat <= 64'b0;
            snake_flat[food_position] <= 1'b1;

            for (i = 0; i < 64; i = i + 1) begin
                if (i < snake_length) begin
                    snake_flat[position[i][1] * 8 + position[i][0]] <= 1'b1;
                end
            end
        end
    end

//---------------------------------------------------------------------------------------------------------------------------
// Food positioning
//---------------------------------------------------------------------------------------------------------------------------
    always @ (posedge clk or posedge rst) begin
        if (rst == 1'b1) begin
            food_positioned <= 1'b1;
            food_position   <= 6'b011101;
        end
        else begin
            if (food_eaten) begin
                food_positioned <= 1'b0;
            end
            else if (~food_positioned) begin
                food_position <= food_position_next;  
                if (snake_flat[food_position_next] != 1'b1) begin 
                    food_positioned <= 1'b1;
                end
            end
        end
    end
//---------------------------------------------------------------------------------------------------------------------------

endmodule
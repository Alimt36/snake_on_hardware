//---------------------------------------------------------------------------------------------------------------------------
// Clean Testbench - Snake Eats 3 Foods (ASCII-safe)
//---------------------------------------------------------------------------------------------------------------------------

`timescale 1ns/1ps

module tb_snake;

//---------------------------------------------------------------------------------------------------------------------------
// Testbench signals
//---------------------------------------------------------------------------------------------------------------------------
    reg clk;
    reg rst;
    reg btn_R, btn_L, btn_U, btn_D;
    
    wire [7:0] ROW;
    wire [7:0] COL;
    
    integer food_count;
    reg [6:0] prev_length;

//---------------------------------------------------------------------------------------------------------------------------
// Instantiate the top module
//---------------------------------------------------------------------------------------------------------------------------
    top dut (
        .ROW(ROW),
        .COL(COL),
        .btn_R(btn_R),
        .btn_L(btn_L),
        .btn_U(btn_U),
        .btn_D(btn_D),
        .clk(clk),
        .rst(rst)
    );

//---------------------------------------------------------------------------------------------------------------------------
// Clock generation
//---------------------------------------------------------------------------------------------------------------------------
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

//---------------------------------------------------------------------------------------------------------------------------
// Display snake grid
//---------------------------------------------------------------------------------------------------------------------------
    task display_snake_grid;
        integer row, col;
        reg [7:0] grid [7:0];
        reg is_food;
        begin
            // Extract snake positions
            for (row = 0; row < 8; row = row + 1) begin
                grid[row] = dut.snake_flat[row*8 +: 8];
            end
            
            // Display grid
            $display("\n    0 1 2 3 4 5 6 7");
            for (row = 0; row < 8; row = row + 1) begin
                $write("  %0d ", row);
                for (col = 0; col < 8; col = col + 1) begin
                    is_food = (dut.snake.food_position == (row * 8 + col)) && dut.snake.food_positioned;
                    
                    if (grid[row][col]) begin
                        if (is_food)
                            $write("* ");
                        else
                            $write("= ");
                    end
                    else
                        $write(". ");   
                end
                $write("\n");
            end
            $display("\nLength: %0d | Foods Eaten: %0d | Head: (%0d,%0d) | Food: (%0d,%0d)", 
                     dut.snake.snake_length, food_count,
                     dut.snake.position[0][0], dut.snake.position[0][1],
                     dut.snake.food_position % 8, dut.snake.food_position / 8);
        end
    endtask

//---------------------------------------------------------------------------------------------------------------------------
// Wait for movement
//---------------------------------------------------------------------------------------------------------------------------
    task wait_snake_move;
        begin
            repeat(2001) @(posedge clk);
        end
    endtask

//---------------------------------------------------------------------------------------------------------------------------
// Press button
//---------------------------------------------------------------------------------------------------------------------------
    task press_button;
        input [1:0] direction;
        begin
            btn_R = 0; btn_L = 0; btn_U = 0; btn_D = 0;
            case(direction)
                2'b00: btn_R = 1;
                2'b01: btn_D = 1;
                2'b10: btn_L = 1;
                2'b11: btn_U = 1;
            endcase
            repeat(5) @(posedge clk);
            btn_R = 0; btn_L = 0; btn_U = 0; btn_D = 0;
            repeat(5) @(posedge clk);
        end
    endtask

//---------------------------------------------------------------------------------------------------------------------------
// Move towards food intelligently
//---------------------------------------------------------------------------------------------------------------------------
    task move_to_food;
        reg [2:0] head_x, head_y, food_x, food_y;
        integer moves;
        begin
            moves = 0;
            
            while (food_count < 3 && moves < 50 && dut.snake.game_run) begin
                head_x = dut.snake.position[0][0];
                head_y = dut.snake.position[0][1];
                food_x = dut.snake.food_position % 8;
                food_y = dut.snake.food_position / 8;
                
                // Check if food was eaten
                if (dut.snake.snake_length != prev_length) begin
                    food_count = food_count + 1;
                    $display("\n>>> FOOD EATEN! Total: %0d <<<", food_count);
                    prev_length = dut.snake.snake_length;
                end
                
                // Stop if we ate 3 foods
                if (food_count >= 3) begin
                    moves = 999;
                end
                else begin
                    // Smart navigation towards food
                    if (head_x < food_x) begin
                        press_button(2'b00);  // Right
                    end
                    else if (head_x > food_x) begin
                        press_button(2'b10);  // Left
                    end
                    else if (head_y < food_y) begin
                        press_button(2'b01);  // Down
                    end
                    else if (head_y > food_y) begin
                        press_button(2'b11);  // Up
                    end
                    
                    wait_snake_move();
                    display_snake_grid();  // Print grid every move!
                    moves = moves + 1;
                end
            end
        end
    endtask

//---------------------------------------------------------------------------------------------------------------------------
// Main test
//---------------------------------------------------------------------------------------------------------------------------
    initial begin
        // Initialize
        rst = 1;
        btn_R = 0; btn_L = 0; btn_U = 0; btn_D = 0;
        food_count = 0;

        $dumpfile("snake_game.vcd");
        $dumpvars(0, tb_snake);

        $display("\n+=======================================+");
        $display("|   Snake Game - Eat 3 Foods Test      |");
        $display("+=======================================+");

        repeat(10) @(posedge clk);
        rst = 0;
        repeat(10) @(posedge clk);
        
        prev_length = dut.snake.snake_length;

        $display("\n=== Initial State ===");
        display_snake_grid();

        // Try to eat 3 foods
        move_to_food();

        // Final state
        if (food_count >= 3) begin
            $display("\n+=======================================+");
            $display("|   SUCCESS! Snake ate 3 foods!        |");
            $display("+=======================================+");
            $display("\n=== Final State ===");
            display_snake_grid();
        end
        else if (!dut.snake.game_run) begin
            $display("\n+=======================================+");
            $display("|   GAME OVER! Snake died!              |");
            $display("+=======================================+");
            display_snake_grid();
        end
        else begin
            $display("\n+=======================================+");
            $display("|   Test timeout - couldn't reach food  |");
            $display("+=======================================+");
        end

        #10000;
        $finish;
    end

//---------------------------------------------------------------------------------------------------------------------------
// Timeout watchdog
//---------------------------------------------------------------------------------------------------------------------------
    initial begin
        #300_000_000;
        $display("\n!!! Simulation timeout !!!");
        $finish;
    end

endmodule
//---------------------------------------------------------------------------------------------------------------------------
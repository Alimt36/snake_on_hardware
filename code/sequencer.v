
module sequencer #(parameter count_to = 67108864) (
    output reg [7:0] ascii_out,

    input      [3:0] tens ,
    input      [3:0] ones ,
    input            rst,
    input            clk
);
    reg [26:0] counter;
    reg [4:0]  state_seq;

    always @ (posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 0;
        end
        else begin
            if (counter == count_to)
                counter <= 0;
            else
                counter <= counter + 1;
        end
    end

    always @ (posedge clk or posedge rst) begin
        if (rst) begin
            state_seq <= 0;
            ascii_out <= 8'h21;  
        end
        else begin
            if (counter == count_to) begin
                if ( ones == 0 and tens == 0 ) begin 
                    ascii_out <= 0 ;
                end
                else begin
                    case (state_seq)
                        5'd0  : begin ascii_out <= (30 + ones) ; state_seq <= 5'd1;  end
                        // 5'd1  : begin ascii_out <= 8'h36; state_seq <= 5'd2;  end
                        5'd2  : begin ascii_out <= 8'h21; state_seq <= 5'd3;  end
                        5'd3  : begin ascii_out <= (30 + ones) ; state_seq <= 5'd4;  end
                        // 5'd4  : begin ascii_out <= 8'h36; state_seq <= 5'd5;  end
                        5'd5  : begin ascii_out <= 8'h21; state_seq <= 5'd6;  end
                        5'd6  : begin ascii_out <= (30 + ones) ; state_seq <= 5'd7;  end
                        // 5'd7  : begin ascii_out <= 8'h36; state_seq <= 5'd8;  end
                        5'd8  : begin ascii_out <= 8'h21; state_seq <= 5'd9;  end
                        5'd9  : begin ascii_out <= 8'h21; state_seq <= 5'd10; end
                        5'd10 : begin ascii_out <= 8'h21;                     end
                        
                        // 5'd11 : begin ascii_out <= 8'h33; state_seq <= 5'd12; end
                        // 5'd12 : begin ascii_out <= 8'h21; state_seq <= 5'd13; end
                        // 5'd13 : begin ascii_out <= 8'h33; state_seq <= 5'd14; end
                        // 5'd14 : begin ascii_out <= 8'h21; state_seq <= 5'd15; end
                        // 5'd15 : begin ascii_out <= 8'h36; state_seq <= 5'd16; end
                        // 5'd16 : begin ascii_out <= 8'h21; state_seq <= 5'd17; end
                        // 5'd17 : begin ascii_out <= 8'h36; state_seq <= 5'd18; end
                        // 5'd18 : begin ascii_out <= 8'h21; state_seq <= 5'd19; end
                        // 5'd19 : begin ascii_out <= 8'h36; state_seq <= 5'd20; end
                        // 5'd20 : begin ascii_out <= 8'h21; state_seq <= 5'd0;  end
                        
                        default: begin ascii_out <= 8'h21; state_seq <= 5'd0; end
                    endcase
                end
                else begin
                    case (state_seq)
                    5'd0  : begin ascii_out <= (30 + ones) ; state_seq <= 5'd1;  end
                    5'd1  : begin ascii_out <= (30 + tens); state_seq <= 5'd2;  end
                    5'd2  : begin ascii_out <= 8'h21; state_seq <= 5'd3;  end
                    5'd3  : begin ascii_out <= (30 + ones) ; state_seq <= 5'd4;  end
                    5'd4  : begin ascii_out <= (30 + tens) ; state_seq <= 5'd5;  end
                    5'd5  : begin ascii_out <= 8'h21; state_seq <= 5'd6;  end
                    5'd6  : begin ascii_out <= (30 + ones) ; state_seq <= 5'd7;  end
                    5'd7  : begin ascii_out <= (30 + tens) ; state_seq <= 5'd8;  end
                    5'd8  : begin ascii_out <= 8'h21; state_seq <= 5'd9;  end
                    5'd9  : begin ascii_out <= 8'h21; state_seq <= 5'd10; end
                    5'd10 : begin ascii_out <= 8'h21;                     end
                    
                    // 5'd11 : begin ascii_out <= 8'h33; state_seq <= 5'd12; end
                    // 5'd12 : begin ascii_out <= 8'h21; state_seq <= 5'd13; end
                    // 5'd13 : begin ascii_out <= 8'h33; state_seq <= 5'd14; end
                    // 5'd14 : begin ascii_out <= 8'h21; state_seq <= 5'd15; end
                    // 5'd15 : begin ascii_out <= 8'h36; state_seq <= 5'd16; end
                    // 5'd16 : begin ascii_out <= 8'h21; state_seq <= 5'd17; end
                    // 5'd17 : begin ascii_out <= 8'h36; state_seq <= 5'd18; end
                    // 5'd18 : begin ascii_out <= 8'h21; state_seq <= 5'd19; end
                    // 5'd19 : begin ascii_out <= 8'h36; state_seq <= 5'd20; end
                    // 5'd20 : begin ascii_out <= 8'h21; state_seq <= 5'd0;  end
                    
                    default: begin ascii_out <= 8'h21; state_seq <= 5'd0; end
                    endcase
                end
            end
        end
    end

endmodule
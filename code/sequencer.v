
module sequencer #(parameter count_to = 67108864) (
    output reg [7:0] ascii_out,

    input      [3:0] tens ,
    input      [3:0] ones ,
    input            rst,
    input            clk
);
    reg [31:0] counter;
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
                if ( ones == 0 && tens == 0 ) begin 
                    ascii_out <= 0 ;
                end
                else if ( tens == 0 ) begin
                    case (state_seq)
                        5'd0  : begin ascii_out <= (8'h30  + ones) ; state_seq <= 5'd2 ; end
                        5'd2  : begin ascii_out <=  8'h21 ;          state_seq <= 5'd3 ; end
                        5'd3  : begin ascii_out <= (8'h30  + ones) ; state_seq <= 5'd5 ; end
                        5'd5  : begin ascii_out <=  8'h21 ;          state_seq <= 5'd6 ; end
                        5'd6  : begin ascii_out <= (8'h30  + ones) ; state_seq <= 5'd8 ; end
                        5'd8  : begin ascii_out <=  8'h21 ;          state_seq <= 5'd9 ; end
                        5'd9  : begin ascii_out <=  8'h21 ;          state_seq <= 5'd10; end
                        5'd10 : begin ascii_out <=  8'h21 ;          state_seq <= 5'd0 ; end
                        
                        default: begin ascii_out <= 8'h21; state_seq <= 5'd0; end
                    endcase
                end
                else begin
                    case (state_seq)
                    5'd0  : begin ascii_out <= (8'h30  + tens); state_seq <= 5'd1;  end
                    5'd1  : begin ascii_out <= (8'h30  + ones); state_seq <= 5'd2;  end
                    5'd2  : begin ascii_out <=  8'h21;          state_seq <= 5'd3;  end
                    5'd3  : begin ascii_out <= (8'h30  + tens); state_seq <= 5'd4;  end
                    5'd4  : begin ascii_out <= (8'h30  + ones); state_seq <= 5'd5;  end
                    5'd5  : begin ascii_out <=  8'h21;          state_seq <= 5'd6;  end
                    5'd6  : begin ascii_out <= (8'h30  + tens); state_seq <= 5'd7;  end
                    5'd7  : begin ascii_out <= (8'h30  + ones); state_seq <= 5'd8;  end
                    5'd8  : begin ascii_out <=  8'h21;          state_seq <= 5'd9;  end
                    5'd9  : begin ascii_out <=  8'h21;          state_seq <= 5'd10; end
                    5'd10 : begin ascii_out <=  8'h21;          state_seq <= 5'd0 ; end
                    
                    default: begin ascii_out <= 8'h21; state_seq <= 5'd0; end
                    endcase
                end
            end
        end
    end

endmodule
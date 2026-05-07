
module direction_maker(
    output reg [1:0] dir ,
    
    input R , L , U , D ,
    input clk , rst 
);

    always @ (posedge clk or posedge rst) begin 

        if (rst) begin 
            dir <= 2'b00;
        end
        else begin
            if (dir == 2'b00) begin       // Right
                if      (R) dir <= 2'b00;
                else if (D) dir <= 2'b01;
                else if (L) dir <= 2'b00;
                else if (U) dir <= 2'b11;
                else        dir <= dir;
            end                           // Down
            else if (dir == 2'b01) begin
                if      (R) dir <= 2'b00;
                else if (D) dir <= 2'b01;
                else if (L) dir <= 2'b10;
                else if (U) dir <= 2'b01;
                else        dir <= dir;
            end                           // Left
            else if (dir == 2'b10) begin
                if      (R) dir <= 2'b10;
                else if (D) dir <= 2'b01;
                else if (L) dir <= 2'b10;
                else if (U) dir <= 2'b11;
                else        dir <= dir;
            end
            else begin                    // Up
                if      (R) dir <= 2'b00;
                else if (D) dir <= 2'b11;
                else if (L) dir <= 2'b10;
                else if (U) dir <= 2'b11;
                else        dir <= dir;
            end
        end

    end

endmodule




`timescale 1ns / 1ps

module font_holder (
    output reg [63:0] shape_flat,

    input  [7:0]      hopefully_ascii_input
);

    reg [63:0] shape_temp;

    always @(*) begin

        if (~(hopefully_ascii_input == 0)) begin
            
            case (hopefully_ascii_input)
                //---------------------------------------------------------------------------------------------------------------------------
                // 0 - 9
                //---------------------------------------------------------------------------------------------------------------------------
                8'h30 : shape_temp = ((64'h7088888888887000) >> 1 );
                8'h31 : shape_temp = ((64'h2060202020207000) >> 1 );
                8'h32 : shape_temp = ((64'h708808102040f800) >> 1 );
                8'h33 : shape_temp = ((64'h7088083008887000) >> 1 );
                8'h34 : shape_temp = ((64'h10305090f8101000) >> 1 );
                8'h35 : shape_temp = ((64'hf88080f008887000) >> 1 );
                8'h36 : shape_temp = ((64'h384080f088887000) >> 1 );
                8'h37 : shape_temp = ((64'hf808102040404000) >> 1 );
                8'h38 : shape_temp = ((64'h7088887088887000) >> 1 );
                8'h39 : shape_temp = ((64'h7088887808106000) >> 1 );
                //---------------------------------------------------------------------------------------------------------------------------
                // walking man 
                //---------------------------------------------------------------------------------------------------------------------------
                8'h10 : shape_temp = ((64'h303078a02030488c) >> 1);
                8'h11 : shape_temp = ((64'h3030706820305058) >> 1);
                8'h12 : shape_temp = ((64'h3030203030202030) >> 1);
                //---------------------------------------------------------------------------------------------------------------------------
                // signs : 
                //---------------------------------------------------------------------------------------------------------------------------
                8'h21 : shape_temp = ((64'h2020202020002000) >> 1);
                //---------------------------------------------------------------------------------------------------------------------------
                default: shape_temp = ((64'h2020202020002000) >> 1);
            endcase

            shape_flat = {
                {shape_temp[56], shape_temp[57], shape_temp[58], shape_temp[59], shape_temp[60], shape_temp[61], shape_temp[62], shape_temp[63]}, 
                {shape_temp[48], shape_temp[49], shape_temp[50], shape_temp[51], shape_temp[52], shape_temp[53], shape_temp[54], shape_temp[55]},
                {shape_temp[40], shape_temp[41], shape_temp[42], shape_temp[43], shape_temp[44], shape_temp[45], shape_temp[46], shape_temp[47]},
                {shape_temp[32], shape_temp[33], shape_temp[34], shape_temp[35], shape_temp[36], shape_temp[37], shape_temp[38], shape_temp[39]},
                {shape_temp[24], shape_temp[25], shape_temp[26], shape_temp[27], shape_temp[28], shape_temp[29], shape_temp[30], shape_temp[31]},
                {shape_temp[16], shape_temp[17], shape_temp[18], shape_temp[19], shape_temp[20], shape_temp[21], shape_temp[22], shape_temp[23]},
                {shape_temp[ 8], shape_temp[ 9], shape_temp[10], shape_temp[11], shape_temp[12], shape_temp[13], shape_temp[14], shape_temp[15]},
                {shape_temp[ 0], shape_temp[ 1], shape_temp[ 2], shape_temp[ 3], shape_temp[ 4], shape_temp[ 5], shape_temp[ 6], shape_temp[ 7]}  
            };
        end
        else begin
            shape_flat = 64'h0;
        end
    end

endmodule
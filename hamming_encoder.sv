// hamming_encoder.sv
module hamming_encoder (
    input  logic [3:0] data_in,       // 4-bit input data
    output logic [6:0] encoded_out    // 7-bit Hamming encoded output
);
    logic p1, p2, p4; // Parity bits

    // Assign data bits to appropriate positions
    assign encoded_out[2] = data_in[0]; // d1
    assign encoded_out[4] = data_in[1]; // d2
    assign encoded_out[5] = data_in[2]; // d3
    assign encoded_out[6] = data_in[3]; // d4

    // Calculate parity bits
    assign p1 = data_in[0] ^ data_in[1] ^ data_in[3]; // Covers positions 1,3,5,7
    assign p2 = data_in[0] ^ data_in[2] ^ data_in[3]; // Covers positions 2,3,6,7
    assign p4 = data_in[1] ^ data_in[2] ^ data_in[3]; // Covers positions 4,5,6,7

    // Assign parity bits
    assign encoded_out[0] = p1; // p1
    assign encoded_out[1] = p2; // p2
    assign encoded_out[3] = p4; // p4

endmodule
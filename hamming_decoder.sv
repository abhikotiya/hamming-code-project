// hamming_decoder.sv
module hamming_decoder (
    input  logic [6:0] encoded_in,   // 7-bit Hamming encoded input
    output logic [3:0] data_out,     // 4-bit decoded output
    output logic       error_detected, // Error detection flag
    output logic       error_corrected // Error correction flag
);
    logic p1, p2, p4; // Received parity bits
    logic s1, s2, s4; // Syndrome bits
    logic [2:0] syndrome; // Combined syndrome

    // Extract data bits
    assign data_out[0] = encoded_in[2]; // d1
    assign data_out[1] = encoded_in[4]; // d2
    assign data_out[2] = encoded_in[5]; // d3
    assign data_out[3] = encoded_in[6]; // d4

    // Extract received parity bits
    assign p1 = encoded_in[0];
    assign p2 = encoded_in[1];
    assign p4 = encoded_in[3];

    // Calculate syndrome bits
    assign s1 = p1 ^ data_out[0] ^ data_out[1] ^ data_out[3]; // 0,2,4,6 or 1,3,5,7
    assign s2 = p2 ^ data_out[0] ^ data_out[2] ^ data_out[3];// 1,2,5,6 or 2,3,6,7
    assign s4 = p4 ^ data_out[1] ^ data_out[2] ^ data_out[3];// 3,4,5,6 or 4,5,6,7

    assign syndrome = {s4, s2, s1};

    always_comb begin
        error_detected = (syndrome != 3'b000);
        error_corrected = 0;

        if (error_detected) begin
            error_corrected = 1;
            data_out[syndrome - 1] = ~data_out[syndrome - 1]; // Correct the error
        end
    end

endmodule
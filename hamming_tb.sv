// hamming_tb.sv
module hamming_tb;
    logic [3:0] data_in;
    logic [6:0] encoded_data;
    logic [3:0] decoded_data;
    logic error_detected, error_corrected;

    hamming_encoder encoder (
        .data_in(data_in),
        .encoded_out(encoded_data)
    );

    hamming_decoder decoder (
        .encoded_in(encoded_data),
        .data_out(decoded_data),
        .error_detected(error_detected),
        .error_corrected(error_corrected)
    );

    initial begin
        $display("Hamming Code Encoder & Decoder Testbench");

        // Test Case 1: No Error
        data_in = 4'b1010;
        #10;
        $display("Input: %b, Encoded: %b, Decoded: %b, Error Detected: %b, Error Corrected: %b", 
                  data_in, encoded_data, decoded_data, error_detected, error_corrected);

        // Test Case 2: Single Bit Error
        encoded_data[3] = ~encoded_data[3]; // Introduce an error
        #10;
        $display("With Error: Encoded: %b, Decoded: %b, Error Detected: %b, Error Corrected: %b", 
                  encoded_data, decoded_data, error_detected, error_corrected);

        $finish;
    end

endmodule
module sample_module (
    input wire clk,
    input wire reset,
    input wire [7:0] data_in,
    output reg [7:0] data_out
);

    always @(posedge clk) begin
        if (reset) begin
            data_out <= 8'b0;
        end else begin
            data_out <= data_in;
        end
    end

endmodule

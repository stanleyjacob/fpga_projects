module sum_array (
    input wire clk,
    input wire reset,
    input wire start,
    input wire [7:0] data_in,
    output reg done,
    output reg [15:0] sum
);

    reg [2:0] count;
    reg [15:0] accumulator;

    always @(posedge clk) begin
        if (reset) begin
            count <= 3'b0;
            accumulator <= 16'b0;
            done <= 1'b0;
            sum <= 16'b0;
        end else if (start) begin
            if (count < 3'd5) begin
                accumulator <= accumulator + data_in;
                count <= count + 3'b1;
            end else begin
                sum <= accumulator;
                done <= 1'b1;
            end
        end
    end

endmodule

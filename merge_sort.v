module merge_sort (
    input wire clk,
    input wire reset,
    input wire start,
    input wire [7:0] data_in,
    output reg done,
    output reg [7:0] sorted_data [0:7]
);

    reg [2:0] state;
    reg [2:0] count;
    reg [2:0] left_idx;
    reg [2:0] right_idx;
    reg [2:0] merge_idx;
    reg [7:0] left_array [0:3];
    reg [7:0] right_array [0:3];

    parameter IDLE = 3'b000;
    parameter LOAD = 3'b001;
    parameter DIVIDE = 3'b010;
    parameter MERGE = 3'b011;
    parameter DONE = 3'b100;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            count <= 3'b0;
            left_idx <= 3'b0;
            right_idx <= 3'b0;
            merge_idx <= 3'b0;
            done <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    if (start) state <= LOAD;
                end
                LOAD: begin
                    sorted_data[count] <= data_in;
                    if (count < 3'd7) count <= count + 3'b1;
                    else state <= DIVIDE;
                end
                DIVIDE: begin
                    if (count < 3'd4) begin
                        left_array[count] <= sorted_data[count];
                        right_array[count] <= sorted_data[count + 4];
                        count <= count + 3'b1;
                    end else begin
                        count <= 3'b0;
                        state <= MERGE;
                    end
                end
                MERGE: begin
                    if (left_idx < 3'd4 && right_idx < 3'd4) begin
                        if (left_array[left_idx] <= right_array[right_idx]) begin
                            sorted_data[merge_idx] <= left_array[left_idx];
                            left_idx <= left_idx + 3'b1;
                        end else begin
                            sorted_data[merge_idx] <= right_array[right_idx];
                            right_idx <= right_idx + 3'b1;
                        end
                        merge_idx <= merge_idx + 3'b1;
                    end else if (left_idx < 3'd4) begin
                        sorted_data[merge_idx] <= left_array[left_idx];
                        left_idx <= left_idx + 3'b1;
                        merge_idx <= merge_idx + 3'b1;
                    end else if (right_idx < 3'd4) begin
                        sorted_data[merge_idx] <= right_array[right_idx];
                        right_idx <= right_idx + 3'b1;
                        merge_idx <= merge_idx + 3'b1;
                    end else state <= DONE;
                end
                DONE: begin
                    done <= 1'b1;
                end
            endcase
        end
    end

endmodule

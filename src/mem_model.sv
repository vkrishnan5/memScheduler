`timescale 1ns/1ns
module mem_model (
	input wire [13:0] queue_data,
	output reg mem_ready,
    output reg [3:0] rownum
);
	reg [3:0] row_buffer;
    initial begin
        mem_ready = 1;
    end
    always@(queue_data) begin
	    mem_ready = 0;
	    if (queue_data[11:8] == row_buffer) begin
		    #20;
	    end else begin
		    #60;
		    row_buffer = queue_data[11:8];
	    end
        rownum = row_buffer;
	    mem_ready = 1;
    end
endmodule

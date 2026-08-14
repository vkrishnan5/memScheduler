module accessScheduler (
   input wire [21:0] queue_in,
   input clk, rst, write_en,
   output full_out 
);

wire mem_ready;
wire [3:0] rownum;
wire [13:0] queue_data;
wire full_sig;
wire empty_sig;

req_queue r1(
    .queue_in(queue_in),
    .clk(clk),
    .rst(rst),
    .write_en(write_en),
    .mem_ready(mem_ready),
    .rownum(rownum),
    .queue_data(queue_data),
    .full_sig(full_sig),
    .empty_sig(empty_sig)
);

mem_model m1(
    .queue_data(queue_data),
    .mem_ready(mem_ready),
    .rownum(rownum)
);

assign full_out = full_sig;
endmodule

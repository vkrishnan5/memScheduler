module mem_model_tb;

reg [13:0] queue_data;
wire mem_ready;
wire [3:0] rownum;

mem_model m1(
    .queue_data(queue_data),
    .mem_ready(mem_ready),
    .rownum(rownum)
);

initial begin
    #5 queue_data = 32'd463;
    #70 queue_data = 32'd1896;
    #70 queue_data = 32'd997;
    #75 queue_data = 32'd998;
end
initial begin
    $monitor("Time: %0t,Ready: %0b, RowNum: %0d",$time, mem_ready, rownum);
end
initial begin
    #300 $finish;
end
endmodule

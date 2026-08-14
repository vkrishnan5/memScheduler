module req_queue_tb;

reg [21:0] queue_in;
reg clk, rst, write_en, mem_ready;
reg [3:0] rownum;
wire [13:0] queue_data;
wire full_sig, empty_sig;

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


always #5 clk = ~clk;

initial begin
    rst = 0;
    rownum = 4'b1010;
    write_en = 1;
    clk = 0;
    #10 rst = 1;
    mem_ready = 0;
end
initial begin
    #100 write_en = 0;
end
initial begin
    repeat(10) begin
        queue_in = $urandom;
//        mem_ready = $urandom;
        #10;
    end
end
initial begin
    //$monitor("Time: %0t, Clock: %0b, Queue Data: %0d, Full_Sig: %0b, Empty_Sig: %0b",$time, clk, queue_data, full_sig, empty_sig);
end
initial begin
    $monitor("Time: %0t, \t Write: %0b, \t Queue In: %0d, \t Mem_Ready: %0b, \t Queue Data: %0d, \t Full_Sig: %0b, \t Empty_Sig: %0b",
              $time, write_en, queue_in, mem_ready, queue_data, full_sig, empty_sig);
end
initial begin
    //$monitor("Time: %0t, Queue In: %0d, Enable: %0b, Mem_Ready: %0b",$time, queue_in, write_en, mem_ready);
end
initial begin
    #200 $finish;
end
initial begin
    $dumpfile("req_queue.vcd");
    $dumpvars(0,req_queue_tb);
end
endmodule


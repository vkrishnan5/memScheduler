module req_queue (
	input wire [21:0] queue_in,
	input wire clk, rst, write_en, mem_ready, 
    input wire [3:0] rownum,
	output reg [13:0] queue_data,
	output full_sig, empty_sig //not reg because we just need it as a wire assigning values
);

	parameter DEPTH = 8;
	parameter WIDTH = 22;
	parameter ADDR_SIZE = $clog2(DEPTH);
	reg [WIDTH-1:0] schedulerQ [0:DEPTH-1];
	reg fifo_empty = 0;
    reg fifo_full = 0;
	reg [ADDR_SIZE:0] count = 0;
	reg [ADDR_SIZE-1:0] rd_ptr = 0,wr_ptr = 0;
	
	

	always@(posedge clk or negedge rst) begin
		if(!rst) begin
			wr_ptr <= 0;
			rd_ptr <= 0;
			queue_data <= 0;
            count <= 0;
		end else begin
            //READ FROM THE QUEUE
			if(!write_en && !fifo_empty && mem_ready) begin
		//		queue_data <= {[10:9]schedulerQ[rd_ptr],[15:14]schedulerQ[rd_ptr],[21:14]schedulerQ[rd_ptr],[12:9]schedulerQ[rd_ptr]};
		//		rd_ptr <= rd_ptr+1;
				count <= count-1;
            //WRITE INTO THE QUEUE
			end else if (write_en && !fifo_full) begin
				schedulerQ[wr_ptr] <= queue_in;
				wr_ptr <= wr_ptr+1;
				count <= count+1;
			end
		end
	end

	always@(*) begin
		if(count == 0) begin
			fifo_empty = 1;
		end
		else if (count[ADDR_SIZE]==1) begin	
			fifo_full = 1;
		end
        else begin
            fifo_empty = 0;
            fifo_full = 0;
        end
	end
	assign full_sig = fifo_full;
	assign empty_sig = fifo_empty;


    //FSM Part
    always@(posedge clk) begin
		if(!write_en && !fifo_empty && mem_ready) begin
			queue_data <= {schedulerQ[rd_ptr][8],schedulerQ[rd_ptr][13],schedulerQ[rd_ptr][21:14],schedulerQ[rd_ptr][12:9]};
			rd_ptr <= rd_ptr+1;
         //   count <= count-1;
        end
    end

endmodule

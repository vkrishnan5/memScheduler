# memScheduler
FCFS memory access scheduler in SystemVerilog — simulates a single-bank memory with row-buffer hit/miss timing, a FIFO request queue, and a top-level scheduler wrapper.

A simple SystemVerilog memory access scheduler, currently implementing first-come-first-served (FCFS) scheduling. The design consists of three modules: req_queue, a FIFO that buffers incoming memory requests (address, read/write, data, valid, timestamp); mem_model, a behavioral single-bank memory model that mimics row-buffer hit/miss timing (fast access on a row hit, slower access on a row miss); and accessScheduler, which wires the two together. This is a simulation-only project (not intended for synthesis) built as a foundation for exploring more advanced scheduling policies in the future.

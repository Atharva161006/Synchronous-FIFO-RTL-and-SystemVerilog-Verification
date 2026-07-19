interface fifo_if ;
logic clk,rst_n,cs;
logic wr_en,rd_en;
logic [31:0]data_in;
logic [31:0]data_out;
logic full;
logic empty;

clocking drv_cb@(posedge clk);
output cs,wr_en,rd_en,data_in;
input full,empty,data_out;
endclocking 

clocking mon_cb@(posedge clk);
default input #1step;
input cs,wr_en,rd_en,data_in;
input full,empty,data_out;
endclocking 

endinterface 

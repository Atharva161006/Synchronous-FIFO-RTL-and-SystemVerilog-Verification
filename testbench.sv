module testbench;
parameter FIFO_DEPTH=8,DATA_WIDTH=32;

fifo_if vif();
environment env;
fifo_sync #(.FIFO_DEPTH(FIFO_DEPTH),.DATA_WIDTH(DATA_WIDTH))
                dut(.clk(vif.clk),.rst_n(vif.rst_n),.cs(vif.cs),.wr_en(vif.wr_en),.rd_en(vif.rd_en),.data_in(vif.data_in),
                .data_out(vif.data_out),.full(vif.full),.empty(vif.empty));
initial begin
vif.clk=0;
forever #5 vif.clk=~vif.clk;
end

initial begin
vif.rst_n=0;
vif.cs=0;
vif.wr_en=0;
vif.rd_en=0;
vif.data_in=0;

repeat(2)@(posedge vif.clk);
vif.rst_n=1;
end

initial begin
env=new(vif);

env.run();
#500;
$finish;
end


endmodule

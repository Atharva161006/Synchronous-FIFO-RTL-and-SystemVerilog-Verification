class driver;
 virtual fifo_if vif;
 mailbox#(transaction)mbx;
 
 function new(input mailbox#(transaction)mbx,input virtual fifo_if vif);
 this.mbx=mbx;
 this.vif=vif;
 endfunction
 
 task run();
 transaction tr;
 wait(vif.rst_n);
 forever begin
 mbx.get(tr);
 @(vif.drv_cb);
 vif.drv_cb.cs<=1;
 vif.drv_cb.wr_en<=tr.wr_en;
 vif.drv_cb.rd_en<=tr.rd_en;
 vif.drv_cb.data_in<=tr.data_in;
 @(vif.drv_cb);
 vif.drv_cb.wr_en<=1'b0;
 vif.drv_cb.rd_en<=1'b0;
 vif.drv_cb.cs<=1'b0;
 
 end
 endtask
 endclass
 

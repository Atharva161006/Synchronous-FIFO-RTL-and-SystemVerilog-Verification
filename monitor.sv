class monitor;
virtual fifo_if vif;
mailbox#(transaction)mbx;

function new(mailbox#(transaction)mbx,virtual fifo_if vif);
this.mbx=mbx;
this.vif=vif;
endfunction

task run();
transaction tr;
wait(vif.rst_n);
forever begin
tr=new();
@(vif.mon_cb);
tr.wr_en=vif.mon_cb.wr_en;
tr.rd_en=vif.mon_cb.rd_en;
tr.data_in=vif.mon_cb.data_in;
tr.full=vif.mon_cb.full;
tr.empty=vif.mon_cb.empty;
tr.data_out = vif.mon_cb.data_out;
$display("[%0t] MON: wr=%0b rd=%0b din=%h dout=%h empty=%0b full=%0b",
         $time,
         tr.wr_en,
         tr.rd_en,
         tr.data_in,
         tr.data_out,
         tr.empty,
         tr.full);


mbx.put(tr);
end
endtask
endclass

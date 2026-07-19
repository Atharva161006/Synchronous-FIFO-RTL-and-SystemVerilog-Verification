class environment;
generator gen;
driver drv;
monitor mon;
scoreboard scb;

mailbox#(transaction)gen_drv_mbx;
mailbox#(transaction)mon_scb_mbx;

virtual fifo_if vif;

function new(virtual fifo_if vif);
this.vif=vif;
endfunction

task run();
gen_drv_mbx=new();
mon_scb_mbx=new();
gen=new(gen_drv_mbx);
drv=new(gen_drv_mbx,vif);
mon=new(mon_scb_mbx,vif);
scb=new(mon_scb_mbx);

fork
gen.run();
drv.run();
mon.run();
scb.run();
join_none


endtask
endclass

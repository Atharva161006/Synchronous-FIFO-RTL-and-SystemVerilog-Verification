class scoreboard;
mailbox#(transaction)mbx;
logic [31:0]ref_q[$];
function new(mailbox#(transaction)mbx);
this.mbx=mbx;
endfunction


task run();
transaction tr;
logic pending_read;
logic [31:0] expected;

forever begin
    mbx.get(tr);

    if (pending_read) begin
        if (tr.data_out == expected)
            $display("PASS");
        else
            $display("FAIL");
        pending_read = 0;
    end

    if (tr.wr_en && !tr.full)
        ref_q.push_back(tr.data_in);

    if (tr.rd_en && !tr.empty) begin
        expected = ref_q.pop_front();
        pending_read = 1;
    end
end


endtask
endclass

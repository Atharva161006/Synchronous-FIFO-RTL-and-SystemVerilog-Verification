class generator;

    mailbox #(transaction) mbx;

    localparam int FIFO_DEPTH = 8;
    localparam int NUM_TRANS  = 30;

    int fifo_count = 0;

    function new(mailbox #(transaction) mbx);
        this.mbx = mbx;
    endfunction

    task run();

        transaction tr;
        bit choose_write;

        repeat(NUM_TRANS) begin

            tr = new();

            if (fifo_count == 0) begin
                // FIFO empty → only write
                assert(tr.randomize() with {
                    wr_en == 1;
                    rd_en == 0;
                });
                fifo_count++;

            end
            else if (fifo_count == FIFO_DEPTH) begin
                // FIFO full → only read
                assert(tr.randomize() with {
                    wr_en == 0;
                    rd_en == 1;
                });
                fifo_count--;

            end
            else begin

                choose_write = $urandom_range(0,1);

                if (choose_write) begin
                    assert(tr.randomize() with {
                        wr_en == 1;
                        rd_en == 0;
                    });
                    fifo_count++;
                end
                else begin
                    assert(tr.randomize() with {
                        wr_en == 0;
                        rd_en == 1;
                    });
                    fifo_count--;
                end

            end

            mbx.put(tr);

        end

    endtask

endclass

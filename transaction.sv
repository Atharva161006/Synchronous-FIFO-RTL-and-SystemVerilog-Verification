class transaction ;

    rand logic [31:0] data_in;

    rand logic wr_en;
    rand logic rd_en;

    logic [31:0] data_out;

    logic full;
    logic empty;
    constraint rw_c {
        wr_en != rd_en;
    }

endclass

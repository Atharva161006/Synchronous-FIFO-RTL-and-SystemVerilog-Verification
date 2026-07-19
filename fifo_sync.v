`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.07.2026 17:50:21
// Design Name: 
// Module Name: fifo_sync
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fifo_sync#(parameter FIFO_DEPTH=8,DATA_WIDTH=32)(
    input clk,rst_n,cs,wr_en,rd_en,input [DATA_WIDTH-1:0]data_in,
    output full,output  empty,output reg [DATA_WIDTH-1:0]data_out
    );
    localparam FIFO_DEPTH_LOG=$clog2(FIFO_DEPTH);
    reg [DATA_WIDTH-1:0]fifo[0:FIFO_DEPTH-1];
    reg[FIFO_DEPTH_LOG:0]wr_ptr;
    reg[FIFO_DEPTH_LOG:0]rd_ptr;
    
    always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        wr_ptr<=0;
    else if(cs && wr_en && !full)begin
            $display("[%0t] DUT WRITE : %h", $time, data_in);
            fifo[wr_ptr[FIFO_DEPTH_LOG-1:0]]<=data_in;
            wr_ptr<=wr_ptr+1'b1;
            end
    end
    
    always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        rd_ptr<=0;
        data_out <= 0;
        end
    else if(cs && rd_en && !empty)begin
            $display("[%0t] DUT READ  : %h", $time,
                 fifo[rd_ptr[FIFO_DEPTH_LOG-1:0]]);
            data_out<=fifo[rd_ptr[FIFO_DEPTH_LOG-1:0]];
            rd_ptr<=rd_ptr+1'b1;
            end
    end
    
    assign empty=(rd_ptr==wr_ptr);
    assign full = (rd_ptr=={~wr_ptr[FIFO_DEPTH_LOG],wr_ptr[FIFO_DEPTH_LOG-1:0]});
            
    
endmodule

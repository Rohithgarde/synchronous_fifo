module SYN_FIFO(clk, reset, data_in, wr, rd, full, empty, data_out);
  parameter ADDRESS = 10, WIDTH = 128, DEPTH = 1024;
  
  input clk, reset, wr, rd;
  input [WIDTH-1:0] data_in;
  output reg full, empty;
  output reg [WIDTH-1:0] data_out;
  
  reg [ADDRESS-1:0] wr_ptr, rd_ptr;
  reg [WIDTH-1:0] memory [DEPTH-1:0];
  reg [ADDRESS-1:0] cur_ptr;
 
  assign full = (cur_ptr == 'd1024);
  assign empty = (cur_ptr == 'd0);
  
  always@(posedge clk)begin
    if(reset == 1)begin
      wr_ptr <= 'b0;
      rd_ptr <= 'b0;
      data_out <= 'b0;
      foreach (memory[i,j])
        memory[i][j] <= 'b0;
    end
    else begin
      if(wr == 1 && full != 1)begin
        memory[wr_ptr] <= data_in;
        wr_ptr <= wr_ptr+1;
      end
      if(rd == 1 && empty!= 1)begin
        data_out <= memory[rd_ptr];
        rd_ptr <= rd_ptr + 1;
      end
      cur_ptr = wr_ptr - rd_ptr;
    end
  end
endmodule

// module SYN_FIFO(
//   input wire clk,             // Clock signal
//   input wire rst,             // Reset signal
//   input wire write_en,        // Write enable
//   input wire read_en,         // Read enable
//   input wire [127:0] data_in, // Input data
//   output wire [127:0] data_out, // Output data
//   output wire full,           // Full signal
//   output wire almost_full,    // Almost Full signal (4 spaces left)
//   output wire empty,          // Empty signal
//   output wire almost_empty    // Almost Empty signal (2 spaces filled)
// );

 

//   // FIFO parameters
//   parameter DEPTH = 1024;
//   parameter WIDTH = 128;

 

//   // Internal FIFO storage
//   reg [WIDTH-1:0] fifo[0:DEPTH-1];
//   reg [9:0] write_ptr;
//   reg [9:0] read_ptr;
//   wire [9:0] fifo_count = write_ptr - read_ptr;
//   wire almost_full_condition = (fifo_count >= (DEPTH - 4));
//   wire almost_empty_condition = (fifo_count <= 2);

 

//   // Full and Empty signals
//   assign full = (fifo_count >= (DEPTH - 1));
//   assign almost_full = (almost_full_condition && !full);
//   assign empty = (fifo_count == 0);
//   assign almost_empty = (almost_empty_condition && !empty);

 

//   always @(posedge clk or posedge rst) begin
//     if (rst) begin
//       write_ptr <= 0;
//       read_ptr <= 0;
//     end else if (write_en) begin
//       fifo[write_ptr] <= data_in;
//       write_ptr <= write_ptr + 1;
//     end

 

//     if (rst) begin
//       read_ptr <= 0;
//     end else if (read_en) begin
//       read_ptr <= read_ptr + 1;
//     end
//   end

 

//   // Assign data_out outside of procedural blocks
//   assign data_out = (read_en) ? fifo[read_ptr] : 128'b0;

 

// endmodule
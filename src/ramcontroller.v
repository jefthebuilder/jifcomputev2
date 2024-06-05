module ramcontroller (
  // ram connections
  inout [7:0] ramdatain1,
  output reg [1:0] bank,
  output reg [1:0] bankgroup,
  output reg active,
  output reg [18:0] addressram1,
  output clockenable,
  output ramclock,
  output reg cs1,
  output reg refresh,
  output reg reset,
  // cpu controller connections
  inout [63:0] data,
  input [63:0] address,
  input read,
  input write,
  input clock
  output done_n,
  input resetin
);
  // kan zijn dat je refresh pin nodig hebt
  reg state;
  case (state) begin
      0: begin
        
      end
    
  end
    
endmodule

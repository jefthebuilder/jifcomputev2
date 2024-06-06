module ramcontroller (
  // ram connections
  input [7:0] ramdatain,
  output reg [7:0] ramdataout,
  output reg [1:0] bank,
  output reg [1:0] bankgroup,
  output reg active,
  output reg [17:0] addressram,
  output clockenable,
  output ramclock,
  output reg cs1,
  output reg refresh,
  output reg reset,
  // cpu controller connections
  input datain;
  output reg [63:0] dataout,
  input [63:0] address,
  input read,
  input write,
  input clock
  output done_n,
  input resetin
);
  // kan zijn dat je refresh pin nodig hebt
  reg state;
  reg pausedn;
  assign ramclock = clock & pausedn;
  always @(edge clock) begin
    case (state) begin
        0: begin
          cs1 <= 0;
          active <= 0;
          bank <= address[63:62];
          bankgroup <= address[61:60];
          addressram[17:0] <= address[59:42];
          state <= 1;
          pausedn <= 1;
        end
      1: begin 
        if (read) begin
          cs <=0;
          act <= 1;
          bank <= address[63:62];
          bankgroup <= address[61:60];
          addressram[16] = 1;
          addressram[15] = 0;
          addressram[14] = 1;
          addressram[12] = 0;
          addressram[10] = 1;
          addressram[9:0] =  address[41:32];
        end
        state <= 2;
      end
      2: begin
        state <= 3;
        pausedn <= 0;
        if ( read)
          begin
            
          end
        

      end

         
    end
  end
    
endmodule

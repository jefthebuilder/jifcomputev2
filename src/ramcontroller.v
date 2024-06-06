module ramcontroller (
  // ram connections
  input [63:0] ramdatain,
  output reg [63:0] ramdataout,
  output reg [1:0] bank,
  output reg [1:0] bankgroup,
  output reg active,
  output reg [17:0] addressram,

  output ramclock,
  output reg cs1,
  output reg refresh,
  output reset,
  // cpu controller connections
  input [63:0] datain;
  output reg [63:0] dataout,
  input [63:0] address,
  input read,
  input write,
  input clock
  output reg done,
  input resetin
);
  // kan zijn dat je refresh pin nodig hebt
  reg [1:0]state;
  reg pausedn;
  
  assign ramclock = clock;
  
  assign reset = resetin;
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
          done <= 0;
          
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
          addressram[9:0] =  address[15:0];
          dataout <= ramdatain;
        end
        if (write) begin
          cs <=0;
          act <= 1;
          bank <= address[63:62];
          bankgroup <= address[61:60];
          addressram[16] = 1;
          addressram[15] = 0;
          addressram[14] = 0;
          addressram[12] = 0;
          addressram[10] = 1;
          addressram[9:0] =  address[15:0];
          ramdataout <= datain;
        end
        state <= 2;
      end
    end
  end
    
endmodule

module ramcontroller (
  // ram connections
  input [7:0] ramdatain,
  output reg [7:0] ramdataout,
  output reg [1:0] bank,
  output reg [1:0] bankgroup,
  output reg active,
  output reg [17:0] addressram,
  output dataclock, // serial data clock
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
  reg state;
  reg pausedn;
  
  assign ramclock = clock & pausedn;
  assign dataclock = clock & ~pausedn;
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
        end
        state <= 2;
      end
      2: begin
        state <= 3;
        pausedn <= 0;
        if ( read)
          begin
            dataout[7:0] = ramdatain;
          end
        if (write) begin
          ramdataout = datain[7:0];
        end
        

      end
      3: begin
        state <= 4;
        pausedn <= 0;
        if ( read)
          begin
            dataout[15:8] = ramdatain;
          end
        if (write) begin
          ramdataout = datain[15:8];
        end
        

      end
      4: begin
        state <= 5;
        pausedn <= 0;
        if ( read)
          begin
            dataout[23:16] = ramdatain;
          end
        if (write) begin
          ramdataout = datain[23:16];
        end
        

      end
      5: begin
        state <= 6;
        pausedn <= 0;
        if ( read)
          begin
            dataout[31:24] = ramdatain;
          end
        if (write) begin
          ramdataout = datain[31:24];
        end
      end
      6: begin
        state <= 7;
        pausedn <= 0;
        if ( read)
          begin
            dataout[39:32] = ramdatain;
          end
        if (write) begin
          ramdataout = datain[39:32];
        end
        

      end
      
      7: begin
        state <= 8;
        pausedn <= 0;
        if ( read)
          begin
            dataout[47:40] = ramdatain;
          end
        if (write) begin
          ramdataout = datain[47:40];
        end

    end
    8: begin
        state <= 9;
        pausedn <= 0;
        if ( read)
          begin
            dataout[55:48] = ramdatain;
          end
        if (write) begin
          ramdataout = datain[55:48];
        end
    end  
      9: begin
        state <= 10;
        pausedn <= 0;
        if ( read)
          begin
            dataout[63:56] = ramdatain;
          end
        if (write) begin
          ramdataout = datain[63:56];
        end
    end  
      10: begin 
        pausedn <= 1;
        cs <= 1;
        done <= 1;
      end
  end
    
endmodule

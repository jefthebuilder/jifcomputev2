module L1Cache(
  input [12:0] address,
  input [63:0] datain,
  output reg [63:0] dataout,
  input clock,
  input read,
  input write
);
  reg [12:0] [63:0] memory;
  always @(negedge clock) begin
    if (read) begin
      dataout <= memory[address];
    end
    if (write) begin
      memory[address] <= datain;
    end
  end
endmodule
parameter Ncores = 8;
module L2SharedCache(
  input [Ncores:0] [12:0] address,
  input [Ncores:0] [63:0] datain,
  output reg [Ncores:0] [63:0] dataout,
  input clock,
  input [Ncores:0] read,
  input [Ncores:0] write
);
  reg [12:0] [63:0] memory;
  always @(negedge clock) begin
    generate
      genvar i;
      for (i=0 i<Ncores; i=i+1) begin
        if (read[i]) begin
          dataout[i] <= memory[address];
            end
        if (write[i]) begin
              memory[address] <= datain[i];
            end
      end
      
    endgenerate
    
  end
endmodule
